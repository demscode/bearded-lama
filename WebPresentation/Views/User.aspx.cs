using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic.Accounts;

namespace WebPresentation.Views
{
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            object userId = RouteData.Values["userid"];
            // access memberships provider to user GetUser(userid, isonline)....
        }
    }
}