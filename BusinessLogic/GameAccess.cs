using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataAccess.GamesTableAdapters;
using DataAccess.UsersTableAdapters;
using DataSets;


namespace BusinessLogic {

    /// <summary>
    /// Business tier class for basic access to 'game' table data.
    /// </summary>
    [System.ComponentModel.DataObject]
    public class GameAccess {

        /// <summary>
        /// Gets a game from a provided game ID.
        /// </summary>
        /// <param name="gameId">gameId to be found</param>
        /// <returns>Matched game</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesRow GetGameById(int gameId) {
            GamesTableAdapter gamesTableAdapter = new GamesTableAdapter();
            Games.GamesDataTable allGames = gamesTableAdapter.GetData();
            return allGames.FindBygameId(gameId);
        }

        /// <summary>
        /// Updates a game entry in the database.
        /// </summary>
        /// <param name="game">game to be updated</param>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Update)]
        public static void UpdateGame(DataRow game) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            adapter.Update(game);
        }

        /// <summary>
        /// Inserts a newly submitted game into the database.
        /// </summary>
        /// <param name="gameName"></param>
        /// <param name="gameDesc"></param>
        /// <param name="tags"></param>
        /// <param name="category"></param>
        /// <param name="publicPackage"></param>
        /// <param name="userId"></param>
        /// <param name="restrict"></param>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Insert)]
        public static void InsertProduct(string gameName, string gameDesc, string tags, string category, 
            object publicPackage, long userId, bool restrict) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            DateTime thisDay = DateTime.Today;
            // pending FTP upload of actual game files
            // pending package management
            adapter.Insert(gameName, gameDesc, tags, category, publicPackage, 0, userId, thisDay, null, restrict);
        }

        /// <summary>
        /// Deletes a game entry from the database.
        /// (revision due, conflicts might occur with foreing keys)
        /// </summary>
        /// <param name="original_ProductId">ID of the game to be deleted</param>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Delete)]
        public static void DeleteProduct(long original_ProductId) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            adapter.Delete(original_ProductId);
        }

        /// <summary>
        /// Utility method for matching a game ID with the username of the uploader.
        /// </summary>
        /// <param name="gameId">ID to be found</param>
        /// <returns>userName of the uploader</returns>
        public static string GetUploader(int gameId) {
            GamesTableAdapter gameAdapter = new GamesTableAdapter();
            UsersTableAdapter userAdapter = new UsersTableAdapter();
            Games.GamesDataTable gameTable = gameAdapter.GetData();
            Users.UsersDataTable userTable = userAdapter.GetData();
            return (userTable.Select("userId = " + gameTable.FindBygameId(gameId).userId)[0])["userName"].ToString();
        }
    }
}
