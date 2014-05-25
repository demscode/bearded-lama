using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPresentation.Templates
{

    public partial class ChatBox : System.Web.UI.UserControl
    {
        public Int32 gameId()
        {
            return Convert.ToInt32(Page.RouteData.Values["id"]);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}