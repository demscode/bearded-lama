using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using DataAccess.GamesTableAdapters;
using DataAccess.UsersTableAdapters;
using DataSets;
using Newtonsoft.Json;


namespace BusinessLogic.Games {

    /// <summary>
    /// Business tier class for basic access to 'game' table data.
    /// </summary>
    [System.ComponentModel.DataObject]
    public class Access {

        /// <summary>
        /// Gets a game from a provided game ID.
        /// </summary>
        /// <param name="gameId">gameId to be found</param>
        /// <returns>Matched game</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static DataSets.Games.GamesRow GetGameById(long gameId) {
            GamesTableAdapter gamesTableAdapter = new GamesTableAdapter();
            DataSets.Games.GamesDataTable allGames = gamesTableAdapter.GetData();
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
        /// <param name="categories"></param>
        /// <param name="publicPackage"></param>
        /// <param name="userId"></param>
        /// <param name="restrict"></param>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Insert)]
        public static void NewGame(string gameName, string gameDesc, string tags, string categories, 
            string publicPackage, long userId, bool restrict) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            DateTime thisDay = DateTime.Today;
            adapter.Insert(gameName, gameDesc, publicPackage, tags, categories, userId, thisDay, null, restrict);
        }

        /// <summary>
        /// Deletes a game entry from the database.
        /// (revision due, conflicts might occur with foreing keys)
        /// </summary>
        /// <param name="original_ProductId">ID of the game to be deleted</param>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Delete)]
        public static void DeleteGame(long original_ProductId) {
            GamesTableAdapter adapter = new GamesTableAdapter();
            adapter.Delete(original_ProductId);
        }

        /// <summary>
        /// Utility method for matching a game ID with the username of the uploader.
        /// </summary>
        /// <param name="gameId">ID to be found</param>
        /// <returns>userName of the uploader</returns>
        public static string GetUploader(long gameId) {
            GamesTableAdapter gameAdapter = new GamesTableAdapter();
            UsersTableAdapter userAdapter = new UsersTableAdapter();
            Users.UsersDataTable userTable = userAdapter.GetData();
            DataSets.Games.GamesDataTable gamesTable = gameAdapter.GetData();

            string gamesUploaderId = (gamesTable.Select(gamesTable.gameIdColumn.ToString() + " = " + gameId)[0])[gamesTable.userIdColumn].ToString();
            return (userTable.Select(userTable.userIdColumn.ToString() + " = " + gamesUploaderId)[0])[userTable.userNameColumn].ToString();
        }

        /// <summary>
        /// Gets an existing instance of a PackageInfo.
        /// </summary>
        /// <param name="gameId">The Games ID.</param>
        /// <returns></returns>
        public static PackageInfo GetPackageInfo(long gameId)
        {
            DataSets.Games.GamesRow gameRow = GetGameById(gameId);
            return Package.ValidateConfiguration(new System.IO.StringReader(gameRow.publicPackage));
        }
    }
}
