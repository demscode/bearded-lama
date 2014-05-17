using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace SOAPGamesService {

    [ServiceContract]
    public interface IGameService {
        [OperationContract]
        Game GetGameById(long id);

        [OperationContract]
        List<Game> GetGamesByTag(string tag);

        [OperationContract]
        List<Game> GetAllMatureGames(bool restrict);

        [OperationContract]
        List<Game> GetAllGames();
    }
}
