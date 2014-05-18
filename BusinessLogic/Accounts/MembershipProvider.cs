using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Configuration.Provider;
using System.Web;
using System.Web.Security;
using DataAccess.UsersTableAdapters;
using DataSets;
using System.Security.Cryptography;
using System.Web.Configuration;

namespace BusinessLogic.Accounts
{
    /// <summary>
    /// Manages storage of user account information, tailored to utilise data
    /// access in the Data Tier of this application.
    /// </summary>
    class Memberships : MembershipProvider
    {
        //
        // Initialise the Provider with important configuration
        //
        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
        {
            base.Initialize(name, config); // ProviderBase method tracks call count

            // Assignments from configuration file
            pApplicationName = GetConfigValue(config["applicationName"], config["name"]);
            pMaxInvalidPasswordAttempts = Convert.ToInt32(GetConfigValue(config["maxInvalidPasswordAttempts"], "5"));
            pPasswordAttemptWindow = Convert.ToInt32(GetConfigValue(config["passwordAttemptWindow"], "10"));
            pMinRequiredNonAlphanumericCharacters = Convert.ToInt32(GetConfigValue(config["minRequiredNonAlphanumericCharacters"], "1"));
            pMinRequiredPasswordLength = Convert.ToInt32(GetConfigValue(config["minRequiredPasswordLength"], "7"));
            pPasswordStrengthRegularExpression = Convert.ToString(GetConfigValue(config["passwordStrengthRegularExpression"], ""));
            pEnablePasswordReset = Convert.ToBoolean(GetConfigValue(config["enablePasswordReset"], "true"));
            pEnablePasswordRetrieval = Convert.ToBoolean(GetConfigValue(config["enablePasswordRetrieval"], "true"));
            pRequiresQuestionAndAnswer = Convert.ToBoolean(GetConfigValue(config["requiresQuestionAndAnswer"], "false"));
            pRequiresUniqueEmail = Convert.ToBoolean(GetConfigValue(config["requiresUniqueEmail"], "true"));

            // Machine key for encryption.
            Configuration cfg =
              WebConfigurationManager.OpenWebConfiguration(System.Web.Hosting.HostingEnvironment.ApplicationVirtualPath);
            pMachineKey = (MachineKeySection)cfg.GetSection("system.web/machineKey");

            switch (config["passwordFormat"])
            {
                case null:
                case "Hashed":
                    pPasswordFormat = MembershipPasswordFormat.Hashed;
                    break;
                case "Encrypted":
                    pPasswordFormat = MembershipPasswordFormat.Encrypted;
                    break;
                case "Clear":
                    pPasswordFormat = MembershipPasswordFormat.Clear;
                    break;
                default:
                    throw new ProviderException("Password format not accepted");
            }
        }

        //
        // Properties
        //
        private string pApplicationName;
        private bool pEnablePasswordReset;
        private bool pEnablePasswordRetrieval;
        private bool pRequiresQuestionAndAnswer;
        private bool pRequiresUniqueEmail;
        private int pMaxInvalidPasswordAttempts;
        private int pPasswordAttemptWindow;
        private MembershipPasswordFormat pPasswordFormat;
        private int pMinRequiredPasswordLength;
        private string pPasswordStrengthRegularExpression;
        private int pMinRequiredNonAlphanumericCharacters;
        private MachineKeySection pMachineKey;

        public override string ApplicationName
        {
            get { return pApplicationName; }
            set { pApplicationName = value; }
        }

        public override bool EnablePasswordReset
        {
            get { return pEnablePasswordReset; }
        }

        public override bool EnablePasswordRetrieval
        {
            get { return pEnablePasswordRetrieval; }
        }

        public override bool RequiresQuestionAndAnswer
        {
            get { return pRequiresQuestionAndAnswer; }
        }

        public override bool RequiresUniqueEmail
        {
            get { return pRequiresUniqueEmail; }
        }

        public override int MaxInvalidPasswordAttempts
        {
            get { return pMaxInvalidPasswordAttempts; }
        }

        public override int PasswordAttemptWindow
        {
            get { return pPasswordAttemptWindow; }
        }

        public override MembershipPasswordFormat PasswordFormat
        {
            get { return pPasswordFormat; }
        }

        public override int MinRequiredNonAlphanumericCharacters
        {
            get { return pMinRequiredNonAlphanumericCharacters; }
        }

        public override int MinRequiredPasswordLength
        {
            get { return pMinRequiredPasswordLength; }
        }

        public override string PasswordStrengthRegularExpression
        {
            get { return pPasswordStrengthRegularExpression; }
        }

        //
        // Implemented methods from Memberships
        //
        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            if (!ValidateUser(username, oldPassword))
            {
                return false;
            }

            ValidatePasswordEventArgs args = new ValidatePasswordEventArgs(username, newPassword, false);
            OnValidatingPassword(args);

            if (args.Cancel)
            {
                if (args.FailureInformation == null)
                {
                    throw new MembershipPasswordException("ChangePassword canceled because new password failed validation.");
                }
                else
                {
                    throw args.FailureInformation;
                }
            }

            string newPasswordHash = EncodePassword(newPassword);
            UsersTableAdapter userAdapter = new UsersTableAdapter();
            int updateStatus = userAdapter.UpdatePasswordHash(newPasswordHash, username);
            return updateStatus == 1 ? true : false;
        }

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUser CreateUser(
            string username, string password,
            string email,
            string passwordQuestion,
            string passwordAnswer,
            bool isApproved,
            object providerUserKey,
            out System.Web.Security.MembershipCreateStatus status)
        {
            // Validate password
            ValidatePasswordEventArgs args = new ValidatePasswordEventArgs(username, password, true);
            OnValidatingPassword(args);
            if (args.Cancel)
            {
                status = MembershipCreateStatus.InvalidPassword;
                return null;
            }

            // Validate email uniqueness
            if (RequiresUniqueEmail && GetUserNameByEmail(email) != null)
            {
                status = MembershipCreateStatus.DuplicateEmail;
                return null;
            }

            MembershipUser user = GetUser(username, false);
            if (user == null)
            {
                UsersTableAdapter userAdapter = new UsersTableAdapter();
                string encodedPassword = EncodePassword(password);
                int insertStatus = userAdapter.Insert(username, email, encodedPassword, DateTime.Now);
                user = GetUser(username, false);
                if (user != null)
                {
                    status = MembershipCreateStatus.Success;
                    return user;
                }
                else
                {
                    status = MembershipCreateStatus.ProviderError;
                }
            }
            else // Validate username uniqueness
            {
                status = MembershipCreateStatus.DuplicateUserName;
            }

            return null;
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override int GetNumberOfUsersOnline()
        {
            throw new NotImplementedException();
        }

        public override string GetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUser GetUser(string username, bool userIsOnline)
        {
            UsersTableAdapter userAdapter = new UsersTableAdapter();
            object userId = userAdapter.GetUserIdFromUserName(username);
            if (userId == null)
            {
                return null;
            }
            else
            {
                MembershipUser user = GetUser(userId, userIsOnline);
                return user;
            }
        }

        public override System.Web.Security.MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            UsersTableAdapter userAdapter = new UsersTableAdapter();
            Users.UsersDataTable userTable = userAdapter.GetData();

            Users.UsersRow userRow = userTable.FindByuserId(long.Parse(providerUserKey.ToString()));
            if (userRow == null)
            {
                return null;
            }
            else
            {
                MembershipUser user = new User(ApplicationName, userRow.userName, providerUserKey, userRow.email, userRow.userBio.ToString(), userRow.adult, userRow.creation);
                return user;
            }
        }

        public override string GetUserNameByEmail(string email)
        {
            UsersTableAdapter userAdapter = new UsersTableAdapter();
            object username = userAdapter.GetUserNameFromEmail(email);
            return username == null ? null : username.ToString();
        }

        public override string ResetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override bool UnlockUser(string userName)
        {
            throw new NotImplementedException();
        }

        public override void UpdateUser(System.Web.Security.MembershipUser user)
        {
            throw new NotImplementedException();
        }

        public override bool ValidateUser(string username, string password)
        {
            bool isValidUser;

            UsersTableAdapter userAdapter = new UsersTableAdapter();
            object passwordHashDb = userAdapter.GetPasswordHashFromUserName(username);
            if (passwordHashDb == null)
            {
                return isValidUser = false;
            }
            else
            {
                isValidUser = EncodePassword(password) == passwordHashDb.ToString();
            }

            return isValidUser;
        }

        //
        // Helper functions
        //
        private string GetConfigValue(string configValue, string defaultValue)
        {
            if (String.IsNullOrEmpty(configValue))
            {
                return defaultValue;
            }

            return configValue;
            {

            }
        }

        //
        // EncodePassword
        //   Encrypts, Hashes, or leaves the password clear based on the PasswordFormat.
        //
        private string EncodePassword(string password)
        {
            string encodedPassword = password;

            switch (PasswordFormat)
            {
                case MembershipPasswordFormat.Clear:
                    break;
                case MembershipPasswordFormat.Encrypted:
                    encodedPassword =
                      Convert.ToBase64String(EncryptPassword(Encoding.Unicode.GetBytes(password)));
                    break;
                case MembershipPasswordFormat.Hashed:
                    HMACSHA1 hash = new HMACSHA1();
                    //hash.Key = HexToByte(pMachineKey.ValidationKey);
                    hash.Key = HexToByte("111222");
                    encodedPassword =
                      Convert.ToBase64String(hash.ComputeHash(Encoding.Unicode.GetBytes(password)));
                    break;
                default:
                    throw new ProviderException("Unsupported password format.");
            }

            return encodedPassword;
        }

        //
        // UnEncodePassword
        //   Decrypts or leaves the password clear based on the PasswordFormat.
        //
        private string UnEncodePassword(string encodedPassword)
        {
            string password = encodedPassword;

            switch (PasswordFormat)
            {
                case MembershipPasswordFormat.Clear:
                    break;
                case MembershipPasswordFormat.Encrypted:
                    password =
                      Encoding.Unicode.GetString(DecryptPassword(Convert.FromBase64String(password)));
                    break;
                case MembershipPasswordFormat.Hashed:
                    throw new ProviderException("Cannot unencode a hashed password.");
                default:
                    throw new ProviderException("Unsupported password format.");
            }

            return password;
        }

        //
        // HexToByte
        //   Converts a hexadecimal string to a byte array. Used to convert encryption
        // key values from the configuration.
        //
        private byte[] HexToByte(string hexString)
        {
            byte[] returnBytes = new byte[hexString.Length / 2];
            for (int i = 0; i < returnBytes.Length; i++)
                returnBytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
            return returnBytes;
        }
    }
}
