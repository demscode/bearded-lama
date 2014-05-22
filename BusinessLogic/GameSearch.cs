using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using DataAccess.GamesTableAdapters;
using DataSets;

namespace BusinessLogic {

    [System.ComponentModel.DataObject]
    public class GameSearch {

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable SearchByName(string searchTerms) {
            string[] search = searchTerms.Split(' ');
            Games.GamesDataTable foundGames = new Games.GamesDataTable();
            GamesTableAdapter adapter = new GamesTableAdapter();
            Games.GamesDataTable allGames = adapter.GetData();
            allGames.CaseSensitive = false;
            foreach (string query in search) {
                DataRow[] temp = allGames.Select("gameName LIKE '*" + query.ToLower() + "*'");
                foreach (DataRow row in temp) {
                    if (!foundGames.Contains(row)) {
                        foundGames.ImportRow(row);
                    }
                }
            }
            return foundGames;
        }

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable SearchByCategory(string searchTerms) {
            string[] search = searchTerms.Split(' ');
            Games.GamesDataTable foundGames = new Games.GamesDataTable();
            GamesTableAdapter adapter = new GamesTableAdapter();
            Games.GamesDataTable allGames = adapter.GetData();
            allGames.CaseSensitive = false;
            foreach (string query in search) {
                DataRow[] temp = allGames.Select("category LIKE '*" + query.ToLower() + "*'");
                foreach (DataRow row in temp) {
                    if (!foundGames.Contains(row)) {
                        foundGames.ImportRow(row);
                    }
                }
            }
            return foundGames;
        }

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable SearchByTags(string searchTerms) {
            string[] search = searchTerms.Split(' ');
            Games.GamesDataTable foundGames = new Games.GamesDataTable();
            GamesTableAdapter adapter = new GamesTableAdapter();
            Games.GamesDataTable allGames = adapter.GetData();
            allGames.CaseSensitive = false;
            foreach (string query in search) {
                DataRow[] temp = allGames.Select("tags LIKE '*" + query.ToLower() + "*'");
                foreach (DataRow row in temp) {
                    if (!foundGames.Contains(row)) {
                        foundGames.ImportRow(row);
                    }
                }
            }
            return foundGames;
        }
    }
}
