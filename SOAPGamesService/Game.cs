using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace SOAPGamesService {

    [DataContract]
    public class Game {
        [DataMember]
        public long Id;
        [DataMember]
        public string Name;
        [DataMember]
        public string Description;
        [DataMember]
        public string[] Tags;
        [DataMember]
        public string Category;
        [DataMember]
        public int Rating;
        [DataMember]
        public bool Restrict;

        public Game() {
        }

        public Game(long id, string name, string description, string[] tags, string category,
                int rating, bool restrict) {
            this.Id = id;
            this.Name = name;
            this.Description = description;
            this.Tags = tags;
            this.Category = category;
            this.Rating = rating;
            this.Restrict = restrict;
        }
    }
}