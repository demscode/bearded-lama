using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPresentation.Templates.UserControls
{
    public partial class EditMembershipUserDetails : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BusinessLogic.Accounts.User user = (BusinessLogic.Accounts.User)System.Web.Security.Membership.GetUser();
            staticUsername.InnerText = user.UserName;
            if (!Page.IsPostBack)
            {
                EditAdult.Checked = user.Adult;
            }
        }

        protected void SaveUserDetailsButton_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) {
                throw new HttpRequestValidationException("User details were failed validation.");
            }

            BusinessLogic.Accounts.User user = (BusinessLogic.Accounts.User)System.Web.Security.Membership.GetUser();
            user.Email = EditEmail.Text == "" ? user.Email : EditEmail.Text;
            user.UserBio = EditUserDescription.Text == "" ? user.UserBio : EditUserDescription.Text;
            user.Adult = EditAdult.Checked;

            try
            {
                System.Web.Security.Membership.UpdateUser(user);
                SaveUserDetailsButton.Text = "Saved";
                SaveUserDetailsButton.CssClass = "btn btn-success btn-block";
                SaveUserDetailsButton.Attributes.Add("disabled", "disabled");
                ResetControlFields();
            }
            catch (MembershipCreateUserException)
            {
                SaveUserDetailsButton.Text = "Saving Failed";
                SaveUserDetailsButton.CssClass = "btn btn-danger btn-block";
            }
        }

        protected void EditEmailValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = Regex.IsMatch(args.Value, @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*") || args.Value == String.Empty;
        }

        protected void EditUserDescriptionValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int maxChars = 200;
            args.IsValid = args.Value.Trim().Length <= maxChars || args.Value == String.Empty;
        }

        private void ResetControlFields()
        {
            BusinessLogic.Accounts.User user = (BusinessLogic.Accounts.User)System.Web.Security.Membership.GetUser();
            EditEmail.Text = "";
            EditUserDescription.Text = "";
            EditAdult.Checked = user.Adult;
        }
    }
}