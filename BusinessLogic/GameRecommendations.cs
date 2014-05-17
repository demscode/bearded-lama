using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataAccess.GamesTableAdapters;
using DataAccess.GameHistoryTableAdapters;
using DataAccess.UsersTableAdapters;
using DataSets;

namespace BusinessLogic {

    /// <summary>
    /// Business tier class for retrieving a DataTable object containing some 
    /// game recommendations based on a specific user or a specific game, or a 
    /// mix of both.
    /// </summary>
    [System.ComponentModel.DataObject]
    public class GameRecommendations {

        /// <summary>
        /// Retrieves a set of game recommendations to be used in Game information pages.
        /// </summary>
        /// <param name="gameId">Id of the game been accessed</param>
        /// <param name="user">Username of the currently logged in user. Submit ""(empty string) 
        /// when there isn't such.</param>
        /// <returns>Strong typed DataTable with selected recommended games.</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable GetGamePageRecommendations(int gameId, string user) {
            GamesTableAdapter gamesTableAdapter = new GamesTableAdapter();
            Games.GamesDataTable allGames = gamesTableAdapter.GetData();
            Dictionary<long, int> scoringTable = new Dictionary<long, int>();

            Games.GamesRow currentGame = (allGames.FindBygameId(gameId));
            string[] currentGameTags = currentGame.tags.Split(',');

            foreach (Games.GamesRow game in allGames) {
                scoringTable.Add(game.gameId, 0);

                if (game.gameId != currentGame.gameId) { // Ignore present Game from recommendations
                    // Test for same author
                    if (game.userId == currentGame.userId) {
                        scoringTable[game.gameId] += 20;
                    }

                    string[] testedGameTags = game.tags.Split(',');

                    // Test for similar Tags
                    foreach (string tag in currentGameTags) {
                        if (testedGameTags.Contains(tag)) {
                            scoringTable[game.gameId] += 50;
                        }
                    }

                    // Test for same category
                    if (game.category == currentGame.category) {
                        scoringTable[game.gameId] += 100;
                    }

                    if (user != "") { // If user logged in... NOT CHECKED!!!
                        scoringTable = GetUserHistoryRecommendations(scoringTable, game, user, ref allGames);
                    }
                }
            }

            return GenerateOrderedGamesTable(scoringTable, ref allGames);
        }

        /// <summary>
        /// Retrieves a set of game recommendations to be used in the user profile page.
        /// </summary>
        /// <param name="user">Username of the currently logged in user.</param>
        /// <returns>Strong typed DataTable with selected recommended games.</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable GetNonGamePageRecommendations(string user) {
            GamesTableAdapter gamesTableAdapter = new GamesTableAdapter();
            DataSets.Games.GamesDataTable allGames = gamesTableAdapter.GetData();
            Dictionary<long, int> scoringTable = new Dictionary<long, int>();
            foreach (Games.GamesRow game in allGames) {
                scoringTable.Add(game.gameId, 0);
                scoringTable = GetUserHistoryRecommendations(scoringTable, game, user, ref allGames);
            }
            return GenerateOrderedGamesTable(scoringTable, ref allGames);
        }

        private static DataSets.Games.GamesDataTable GenerateOrderedGamesTable(Dictionary<long, int> scoringTable,
                ref Games.GamesDataTable allGames) {
            Games.GamesDataTable selectedGames = new Games.GamesDataTable();
            scoringTable = scoringTable.OrderByDescending(x => x.Value).ToDictionary(x => x.Key, x => x.Value);
            Dictionary<long, int>.Enumerator enume = scoringTable.GetEnumerator();
            for (int i = 0; i < scoringTable.Count; i++) {
                enume.MoveNext();
                selectedGames.ImportRow(allGames.FindBygameId(enume.Current.Key));
            }
            return selectedGames;
        }

        private static Dictionary<long, int> GetUserHistoryRecommendations(Dictionary<long, int> scoringTable,
                Games.GamesRow game, string user, ref Games.GamesDataTable allGames) {
            UsersTableAdapter userAdaper = new UsersTableAdapter();
            Users.UsersDataTable userTable = userAdaper.GetData();
            long gamerId = long.Parse((userTable.Select("userName = '" + user + "'")[0])["userId"].ToString());

            GameHistoryTableAdapter gameAdapter = new GameHistoryTableAdapter();
            GameHistory.GameHistoryDataTable historyTable = gameAdapter.GetData();
            DataRow[] userHistoryTable = historyTable.Select("userId = " + gamerId);
            Games.GamesDataTable gamesPlayed = new Games.GamesDataTable();
            foreach (DataRow historyRow in userHistoryTable) {
                gamesPlayed.ImportRow(allGames.FindBygameId(long.Parse(historyRow["gameId"].ToString())));
            }
            string[] gamePlayedTags = game.tags.Split(',');
            foreach (Games.GamesRow gamePlayed in gamesPlayed) {
                if (game.gameId != gamePlayed.gameId) { // Ignore present Game from recommendations

                    // Test for same author
                    if (game.userId == gamePlayed.userId) {
                        scoringTable[game.gameId] += 10;
                    }

                    string[] testedGameTags = game.tags.Split(',');

                    // Test for similar Tags
                    foreach (string tag in gamePlayedTags) {
                        if (testedGameTags.Contains(tag)) {
                            scoringTable[game.gameId] += 25;
                        }
                    }

                    // Test for same category
                    if (game.category == gamePlayed.category) {
                        scoringTable[game.gameId] += 50;
                    }
                }
            }

            return scoringTable;
        }
    }
}
