using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
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
            EditAdult.Checked = user.Adult;
        }

        protected void SaveUserDetailsButton_Click(object sender, EventArgs e)
        {
            bool allValidated = EditEmailValidator.IsValid && EditUserDescriptionValidator.IsValid;
            if (!Page.IsValid) {
            }
        }

        protected void EditEmailValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = Regex.IsMatch(args.Value, @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
        }

        protected void EditUserDescriptionValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int maxChars = 200;
            args.IsValid = args.Value.Trim().Length <= maxChars;
        }
    }
}