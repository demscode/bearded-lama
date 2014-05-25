using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic.Games;
using DataSets;

namespace WebPresentation.Views {
    public partial class Find : System.Web.UI.Page {

        protected string query;

        protected void Page_Load(object sender, EventArgs e) {
            query = Convert.ToString(Page.RouteData.Values["search_terms"]);

            searchQuery.InnerText = query;

            if (!IsPostBack) {

                Games.GamesDataTable nameTable = Search.SearchByName(query);
                if (nameTable.Count == 0) {
                    nameResultsHeader.InnerText = "No game name matches :(";
                }
                nameRepeater.DataSource = nameTable;
                nameRepeater.DataBind();

                Games.GamesDataTable categoryTable = Search.SearchByCategory(query);
                if (categoryTable.Count == 0) {
                    categoryResultsHeader.InnerText = "No game category matches :(";
                }
                categoryRepeater.DataSource = categoryTable;
                categoryRepeater.DataBind();

                Games.GamesDataTable tagsTable = Search.SearchByTags(query);
                if (tagsTable.Count == 0) {
                    tagsResultsHeader.InnerText = "No game tag matches :(";
                }
                tagsRepeater.DataSource = tagsTable;
                tagsRepeater.DataBind();
            }

        }
    }
}