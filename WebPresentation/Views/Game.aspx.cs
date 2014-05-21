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
            Games.GamesRow gameData = GameAccess.GetGameById(gameId);
            // Pending getting username from userId
            //long gamerId = long.Parse((userTable.Select("userName = '" + user + "'")[0])["userId"].ToString());

            GamePageHeader.InnerText = gameData.gameName;
            gameDescription.InnerText = gameData.gameDesc;
            gameCategory.InnerText = gameData.category;
            gameTags.InnerText = gameData.tags;
            gameRating.InnerText = gameData.rating.ToString();
            gameUploader.InnerText = gameData.userId.ToString();// replace with username
            gameUpDate.InnerText = gameData.subDate.ToShortDateString();
            if (gameData.restrict) {
                gameRestrict.InnerText = "Yes";
            } else {
                gameRestrict.InnerText = "No";
            }

            BusinessLogic.Accounts.User user = (BusinessLogic.Accounts.User)System.Web.Security.Membership.GetUser();

            Games.GamesDataTable table = GameRecommendations.GetGamePageRecommendations(gameId, user.UserName);

            recommendedGame1.InnerHtml = GameBoxOutput(table[0]);
            recommendedGame2.InnerHtml = GameBoxOutput(table[1]);
            recommendedGame3.InnerHtml = GameBoxOutput(table[2]);
            recommendedGame4.InnerHtml = GameBoxOutput(table[3]);
        }

        private string GameBoxOutput(Games.GamesRow game) {
            return "<article class=\"thumbnail game-short\">" +
                "<img src=\"http://placehold.it/600x150\" class=\"img-responsive img-rounded\"" +
                "alt=\"placeholder for game image if avail\" />" +
                "<button class=\"btn btn-primary btn-sm btn-block\" type=\"button\" onclick=\"window.location='/g/" +
                game.gameId.ToString() + "';\">Play »</button>" +
                "<hr />" +
                "<h3>" + game.gameName + " <small>by " + game.userId.ToString() + "</small></h3>" + // pending actually username
                "<p>" + game.gameDesc + "</p>" +
                "</article>";
        }
    }
}