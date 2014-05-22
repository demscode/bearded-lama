using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPresentation.Templates
{
    public partial class Container : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ConstructLoggedInUserProfileLink(object sender, EventArgs e)
        {
            string userId = System.Web.Security.Membership.GetUser().ProviderUserKey.ToString();

            RouteValueDictionary parameters = new RouteValueDictionary {
                {"userid", userId}
            };
            VirtualPathData userProfilePath = RouteTable.Routes.GetVirtualPath(null, "user-profile", parameters);
            HyperLink link = (HyperLink)sender;
            link.NavigateUrl = userProfilePath.VirtualPath;
            link.Attributes.Add("data-toggle", "dropdown");
        }
    }
}