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

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        protected static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("Home",
                "",
                "~/Views/Index.aspx");

            routes.MapPageRoute("register",
                "u/register",
                "~/Views/Access.aspx");

            routes.MapPageRoute("login",
                "u/login",
                "~/Views/Access.aspx");

            //routes.MapPageRoute("Unique game page",
            //    "g/{id}",
            //    "~/Views/Game.aspx");

            //routes.MapPageRoute("User settings page",
            //    "u/settings",
            //    "~/Views/User.aspx");

            //routes.MapPageRoute("User page by ID",
            //    "u/{id}",
            //    "~/Views/User.aspx");

            //routes.MapPageRoute("User page by username",
            //    "u/{username}",
            //    "~/Views/User.aspx");

            //routes.MapPageRoute("Game submission page",
            //    "u/submit",
            //    "~/Views/User.aspx");

            //routes.MapPageRoute("Find game page",
            //    "f/{genre}", // Needs more research
            //    "~/Views/Find.aspx");
        }
    }
}