using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace WebPresentation.Templates.UserControls
{
    public partial class SubmitGame : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submitPackageButton_ServerClick(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (AttachPackage.HasFile)
                {
                }
                else
                {
                }
            }
        }
    }
}