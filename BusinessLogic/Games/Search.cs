using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using DataAccess.GamesTableAdapters;
using DataSets;

namespace BusinessLogic.Games {

    [System.ComponentModel.DataObject]
    public class Search {

        /// <summary>
        /// Query for game results based on their name. Use '-' in the string 
        /// to do multiple queries in the same search.
        /// </summary>
        /// <param name="searchTerms">Query</param>
        /// <returns>Matching games by name</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable SearchByName(string searchTerms) {
            string[] search = searchTerms.Split('-');
            DataSets.Games.GamesDataTable foundGames = new DataSets.Games.GamesDataTable();
            GamesTableAdapter adapter = new GamesTableAdapter();
            DataSets.Games.GamesDataTable allGames = adapter.GetData();
            allGames.CaseSensitive = false;
            foreach (string query in search) {
                DataRow[] temp = allGames.Select("gameName LIKE '*" + query.ToLower() + "*'");
                foreach (DataRow row in temp) {
                    if (foundGames.Select("gameId = " + row["gameId"].ToString()).Length == 0) {
                        foundGames.ImportRow(row);
                    }
                }
            }
            return foundGames;
        }

        /// <summary>
        /// Query for game results based on their category. Use '-' in the string 
        /// to do multiple queries in the same search.
        /// </summary>
        /// <param name="searchTerms">Query</param>
        /// <returns>Matching games by category</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable SearchByCategory(string searchTerms) {
            string[] search = searchTerms.Split('-');
            DataSets.Games.GamesDataTable foundGames = new DataSets.Games.GamesDataTable();
            GamesTableAdapter adapter = new GamesTableAdapter();
            DataSets.Games.GamesDataTable allGames = adapter.GetData();
            allGames.CaseSensitive = false;
            foreach (string query in search) {
                DataRow[] temp = allGames.Select("categories LIKE '*" + query.ToLower() + "*'");
                foreach (DataRow row in temp) {
                    if (foundGames.Select("gameId = " + row["gameId"].ToString()).Length == 0) {
                        foundGames.ImportRow(row);
                    }
                }
            }
            return foundGames;
        }

        /// <summary>
        /// Query for game results based on their tags. Use '-' in the string 
        /// to do multiple queries in the same search.
        /// </summary>
        /// <param name="searchTerms">Query</param>
        /// <returns>Matching games by tags</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable SearchByTags(string searchTerms) {
            string[] search = searchTerms.Split('-');
            DataSets.Games.GamesDataTable foundGames = new DataSets.Games.GamesDataTable();
            GamesTableAdapter adapter = new GamesTableAdapter();
            DataSets.Games.GamesDataTable allGames = adapter.GetData();
            allGames.CaseSensitive = false;
            foreach (string query in search) {
                DataRow[] temp = allGames.Select("tags LIKE '*" + query.ToLower().Replace(' ', ',') + "*'");
                foreach (DataRow row in temp) {
                    if (foundGames.Select("gameId = " + row["gameId"].ToString()).Length == 0) {
                        foundGames.ImportRow(row);
                    }
                }
            }
            return foundGames;
        }
    }
}
