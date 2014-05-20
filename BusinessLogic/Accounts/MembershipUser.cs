using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;

namespace BusinessLogic.Accounts
{
    /// <summary>
    /// Exposes an instance of a users membership information.
    /// </summary>
    public class User : MembershipUser
    {

        private string _UserBio;
        private bool _Adult;

        public string UserBio
        {
            get { return _UserBio; }
            set { _UserBio = value; }
        }
        public bool Adult
        {
            get { return _Adult; }
            set { _Adult = value; }
        }

        public User(string providername,
            string username,
            object providerUserKey,
            string email,
            string userBio,
            bool adult,
            DateTime creationDate) :
            base(providername,
                    username,
                    providerUserKey,
                    email,
                    null,
                    null,
                    false,
                    false,
                    creationDate,
                    DateTime.Now,
                    DateTime.Now,
                    DateTime.Now,
                    DateTime.Now)
        {
            this.UserBio = userBio;
            this.Adult = adult;
        }
    }
}
