using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPresentation.Templates.UserControls {
    public partial class GameBox : System.Web.UI.UserControl {
        protected void Page_Load(object sender, EventArgs e) {
            PlayButton.NavigateUrl = GetRouteUrl("game-page", new RouteValueDictionary { {"id", GameId.ToString()} });
            gameName.InnerText = GameName;
            category.InnerText = GameCategory;
            gameDesc.InnerText = GameDescription;
        }

        public long GameId { get; set; }
        public string GameName { get; set; }
        public string GameCategory { get; set; }
        public string GameDescription { get; set; }
    }
}