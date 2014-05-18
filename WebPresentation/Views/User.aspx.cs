using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using BusinessLogic.Accounts;

namespace WebPresentation.Views
{
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            long userId = long.Parse(RouteData.Values["userid"].ToString());
            BusinessLogic.Accounts.User user = (BusinessLogic.Accounts.User)System.Web.Security.Membership.Provider.GetUser(userId, false);
            if (user == null)
            {
                Response.StatusCode = 404;
                Response.StatusDescription = "User profile not found.";
                Response.Redirect(GetRouteUrl("error-404"));
            }
        }
    }
}