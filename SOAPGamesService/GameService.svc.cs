using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Web;
using DataAccess.GamesTableAdapters;
using DataSets;

namespace SOAPGamesService {
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "GameService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select GameService.svc or GameService.svc.cs at the Solution Explorer and start debugging.
    public class GameService : IGameService {

        private Games.GamesDataTable InitGamesTable() {
            GamesTableAdapter adapter = new GamesTableAdapter();
            Games.GamesDataTable table = adapter.GetData();
            return table;
        }

        private Game TableRowToGame(DataRow row) {
            if (row is Games.GamesRow) {
                Games.GamesRow game = (Games.GamesRow)row;
                string[] tags = game.tags.Split(',');
                return new Game(game.gameId, game.gameName, game.gameDesc, tags, game.categories, game.rating, game.restrict);
            } else {
                string[] tags = row["tags"].ToString().Split(',');
                return new Game(long.Parse(row["gameId"].ToString()), row["gameName"].ToString(), row["gameDesc"].ToString(), tags, 
                    row["category"].ToString(), Int32.Parse(row["rating"].ToString()), Boolean.Parse(row["restrict"].ToString()));
            }
        }

        public Game GetGameById(long id) {
            Games.GamesDataTable gamesTable = InitGamesTable();
            Games.GamesRow game = gamesTable.FindBygameId(id);
            return TableRowToGame(game);
        }

        public List<Game> GetGamesByTag(string tag) {
            Games.GamesDataTable gamesTable = InitGamesTable();
            List<Game> selectedGames = new List<Game>();
            DataRow[] matchedGames = gamesTable.Select("tags LIKE '*" + tag + "*'");
            foreach (DataRow game in matchedGames) {
                selectedGames.Add(TableRowToGame(game));
            }
            return selectedGames;
        }

        public List<Game> GetAllMatureGames(bool restrict) {
            Games.GamesDataTable gamesTable = InitGamesTable();
            List<Game> selectedGames = new List<Game>();
            DataRow[] matchedGames = gamesTable.Select("restrict = '" + restrict.ToString() + "'");
            foreach (DataRow game in matchedGames) {
                selectedGames.Add(TableRowToGame(game));
            }
            return selectedGames;
        }

        public List<Game> GetAllGames() {
            Games.GamesDataTable gamesTable = InitGamesTable();
            List<Game> allGames = new List<Game>();
            foreach (Games.GamesRow game in gamesTable) {
                allGames.Add(TableRowToGame(game));
            }
            return allGames;
        }
    }
}
