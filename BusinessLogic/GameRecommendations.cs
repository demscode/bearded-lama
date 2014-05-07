using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Web;
using DataAccess.GamesTableAdapters;
using DataAccess.GameHistoryTableAdapters;
using DataAccess.UsersTableAdapters;
using DataSets;

namespace BusinessLogic {

    [System.ComponentModel.DataObject]
    class GameRecommendations {

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable GetGamePageRecommendations(int gameId, System.Security.Principal.IPrincipal user) {
            GamesTableAdapter gamesTableAdapter = new GamesTableAdapter();
            Games.GamesDataTable allGames = gamesTableAdapter.GetData();
            Dictionary<long, int> scoringTable = new Dictionary<long, int>();

            Games.GamesRow currentGame = (Games.GamesRow)((allGames.Select("gameId = " + gameId))[0]);
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

                    if (user.Identity.IsAuthenticated) { // If user logged in... NOT CHECKED!!!
                        scoringTable = GetUserHistoryRecommendations(scoringTable, game, user.Identity.Name, ref allGames);
                    }
                }
            }

            return GenerateOrderedGamesTable(scoringTable, ref allGames);
        }

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesDataTable GetNonGamePageRecommendations(System.Security.Principal.IPrincipal user) {
            GamesTableAdapter gamesTableAdapter = new GamesTableAdapter();
            DataSets.Games.GamesDataTable allGames = gamesTableAdapter.GetData();
            Dictionary<long, int> scoringTable = new Dictionary<long, int>();
            foreach (Games.GamesRow game in allGames) {
                scoringTable.Add(game.gameId, 0);
                scoringTable = GetUserHistoryRecommendations(scoringTable, game, user.Identity.Name, ref allGames);
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
                selectedGames.AddGamesRow((Games.GamesRow)(allGames.Select("gameID = " + enume.Current.Key)[0]));
            }
            return selectedGames;
        }

        private static Dictionary<long, int> GetUserHistoryRecommendations(Dictionary<long, int> scoringTable,
                Games.GamesRow game, string user, ref Games.GamesDataTable allGames) {
            UsersTableAdapter userAdaper = new UsersTableAdapter();
            Users.UsersDataTable userTable = userAdaper.GetData();
            long gamerId = ((Users.UsersRow)(userTable.Select("userName = " + user)[0])).userId;

            GameHistoryTableAdapter gameAdapter = new GameHistoryTableAdapter();
            GameHistory.GameHistoryDataTable historyTable = gameAdapter.GetData();
            GameHistory.GameHistoryDataTable userHistoryTable = (GameHistory.GameHistoryDataTable)
                (historyTable.Select("userId = " + gamerId)).CopyToDataTable();
            Games.GamesDataTable gamesPlayed = new Games.GamesDataTable();
            foreach (GameHistory.GameHistoryRow historyRow in userHistoryTable) {
                gamesPlayed.AddGamesRow((Games.GamesRow)(allGames.Select("gameID = " + historyRow.gameId)[0]));
            }
            string[] gamePlayedTags = game.tags.Split(',');
            foreach (Games.GamesRow gamePlayed in gamesPlayed) {

                if (game.userId == gamePlayed.userId) {
                    scoringTable[game.gameId] += 10;
                }

                string[] testedGameTags = game.tags.Split(',');

                foreach (string tag in gamePlayedTags) {
                    if (testedGameTags.Contains(tag)) {
                        scoringTable[game.gameId] += 25;
                    }
                }

                if (game.category == gamePlayed.category) {
                    scoringTable[game.gameId] += 50;
                }
            }

            return scoringTable;
        }
    }
}
