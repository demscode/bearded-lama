using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BusinessLogic;
using BusinessLogic.Games;
using DataSets;
using Newtonsoft.Json;

namespace WebPresentation.Views {
    public partial class Game : System.Web.UI.Page {

        protected int gameId;

        protected void Page_Load(object sender, EventArgs e) {
            gameId = Convert.ToInt32(Page.RouteData.Values["id"]);
            Games.GamesRow gameData = BusinessLogic.Games.Access.GetGameById(gameId);

            BuildGameTag(gameData.publicPackage);
            GamePageHeader.InnerText = gameData.gameName;
            gameDescription.InnerText = gameData.gameDesc;
            gameCategory.InnerText = gameData.categories;
            gameTags.InnerText = gameData.tags;
            gameRating.InnerText = gameData.rating.ToString();
            gameUploader.InnerText = BusinessLogic.Games.Access.GetUploader(gameId);
            gameUpDate.InnerText = gameData.subDate.ToShortDateString();
            if (gameData.restrict) {
                gameRestrict.InnerText = "Yes";
            } else {
                gameRestrict.InnerText = "No";
            }

            if (!IsPostBack) {

                BusinessLogic.Accounts.User user = (BusinessLogic.Accounts.User)System.Web.Security.Membership.GetUser();
                string userName;
                if (user == null) {
                    userName = "";
                } else {
                    userName = user.UserName;
                }
                Games.GamesDataTable table = BusinessLogic.Games.Recommend.GetGamePageRecommendations(gameId, userName);

                Repeater1.DataSource = table.Take(4);
                Repeater1.DataBind();
            }
        }

        private void BuildGameTag(string packageJsonString)
        {
            PackageInfo info = Package.DeserialiaseConfiguration(new System.IO.StringReader(packageJsonString));
            string element;
            string elementid;
            string height;
            string width;
            info.EntryPoint.TryGetValue("element", out element);
            info.EntryPoint.TryGetValue("elementid", out elementid);
            info.EntryPoint.TryGetValue("height", out height);
            info.EntryPoint.TryGetValue("width", out width);

            HtmlGenericControl gameMold = new HtmlGenericControl(element);
            gameMold.Attributes.Add("id", elementid);
            gameMold.Attributes.Add("height", height);
            gameMold.Attributes.Add("width", width);
            GameContainerPlaceholder.Controls.Add(gameMold);

            HtmlGenericControl[] scriptMolds = new HtmlGenericControl[info.Data["js"].Count];
            for (int i = 0; i < info.Data["js"].Count; i++)
            {
                scriptMolds[i] = new HtmlGenericControl("script");
                scriptMolds[i].Attributes.Add("src", "/Uploads/Public/" + gameId + "/" + info.Data["js"][i]);
                scriptMolds[i].Attributes.Add("type", "text/javascript");
                ScriptsPlaceholder.Controls.Add(scriptMolds[i]);
            }
        }
    }
}