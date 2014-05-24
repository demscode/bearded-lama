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
            ValidUserHandler();

            BusinessLogic.Accounts.User user = (BusinessLogic.Accounts.User)System.Web.Security.Membership.GetUser();

            UserPageHeader.InnerText = Page.Title + ": " + user.UserName;
            ddJoined.InnerText = user.CreationDate.ToShortDateString();
            ddEmail.InnerText = user.Email;
            ddDescription.InnerText = user.UserBio;
        }

        /// <summary>
        /// If the page doesn't exist because there is no valid user information then this redirects the viewer to a pseudo 404 error page.
        /// </summary>
        private void ValidUserHandler()
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