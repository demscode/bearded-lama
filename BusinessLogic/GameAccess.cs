using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataAccess.GamesTableAdapters;
using DataSets;


namespace BusinessLogic {

    [System.ComponentModel.DataObject]
    public class GameAccess {

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesRow GetGameById(int gameId) {
            GamesTableAdapter gamesTableAdapter = new GamesTableAdapter();
            Games.GamesDataTable allGames = gamesTableAdapter.GetData();
            return allGames.FindBygameId(gameId);
        }

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Update)]
        public static void UpdateGame(DataRow game) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            adapter.Update(game);
        }

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Insert)]
        public static void InsertProduct(string gameName, string gameDesc, string tags, string category, 
            object publicPackage, long userId, bool restrict) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            DateTime thisDay = DateTime.Today;
            // pending FTP upload of actual game files
            // pending package management
            adapter.Insert(gameName, gameDesc, tags, category, publicPackage, 0, userId, thisDay, null, restrict);
        }

        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Delete)]
        public static void DeleteProduct(long original_ProductId) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            adapter.Delete(original_ProductId);
        }
    }
}
