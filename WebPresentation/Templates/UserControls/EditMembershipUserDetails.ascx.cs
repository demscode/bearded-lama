using System;
using System.Collections.Generic;
using System.Linq;
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
        }
    }
}