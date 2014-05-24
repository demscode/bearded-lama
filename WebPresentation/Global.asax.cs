using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace WebPresentation
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);

        }

        protected static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("home",
                "",
                "~/Views/Index.aspx");

            routes.MapPageRoute("register",
                "u/register",
                "~/Views/Register.aspx");

            routes.MapPageRoute("login",
                "u/login",
                "~/Views/Login.aspx");

            routes.MapPageRoute("about",
                "about",
                "~/Views/About.aspx");

            routes.MapPageRoute("game-submit",
                "g/submit",
                "~/Views/MembersOnly/GameSubmit.aspx");

            routes.MapPageRoute("game-page",
                "g/{id}",
                "~/Views/Game.aspx");

            routes.MapPageRoute("account-settings",
                "u/settings",
                "~/Views/MembersOnly/Settings.aspx");

            routes.MapPageRoute("user-profile",
                "u/{userid}",
                "~/Views/User.aspx",
                true,
                new RouteValueDictionary { { "userid", "" } },
                new RouteValueDictionary { { "userid", "[0-9]+" } });

            //routes.MapPageRoute("username-profile",
            //    "u/~{username}",
            //    "~/Views/User.aspx",
            //    true,
            //    new RouteValueDictionary { { "username", "" } },
            //    new RouteValueDictionary { { "username", "\\w+" } });

            routes.MapPageRoute("error-404",
                "404",
                "~/Views/Errors/404.aspx");

            //routes.MapPageRoute("User page by username",
            //    "u/{username}",
            //    "~/Views/User.aspx");

            //routes.MapPageRoute("Find game page",
            //    "f/{genre}", // Needs more research
            //    "~/Views/Find.aspx");
        }
    }
}