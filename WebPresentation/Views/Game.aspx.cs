using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using DataSets;

namespace WebPresentation.Views {
    public partial class Game : System.Web.UI.Page {

        protected int gameId;

        protected void Page_Load(object sender, EventArgs e) {
            gameId = Convert.ToInt32(Page.RouteData.Values["id"]);
            Games.GamesRow gameData = BusinessLogic.Games.Access.GetGameById(gameId);

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
    }
}