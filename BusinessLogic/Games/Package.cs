using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Configuration;
using Ionic.Zip;
using Newtonsoft.Json;
using Newtonsoft.Json.Schema;
using Newtonsoft.Json.Linq;
using System.Xml.Linq;

namespace BusinessLogic.Games
{
    /// <summary>
    /// The Package class handles submission, validation and updating of user game packages.
    /// 
    /// A Game Package consists of game files and a configuration file, bearded.json; configuration attributes
    /// are supplied by the user to give information about the available game files, game entry points and
    /// game metadata like gaming instructions.
    /// </summary>
    static public class Package
    {
        // json-schema.org
        // TODO: move as file to top level of solution, and as configuration setting
        static private string packageSchema = @"
{
    'description': 'Game Package schema for Bearded Lama',
    'type': 'object',
    'properties': {
        'name': {
            'type': 'string'
        },
        'identifier': {
            'type': 'string'
        },
        'information': {
            'type': 'string'
        },
        'instruction': {
            'type': 'string'
        },
        'data': {
            'description': 'Files required for the Game',
            'type': 'object',
            'required': true,
            'js': {
                'type': 'array',
                'items': {
                    'type': 'string'
                },
                'minItems': 1,
                'required': true
            }
        },
        'entry': {
            'description': 'Properties for the HTML entry point of the Game',
            'element': {
                'type': 'string',
                'required': true
            },
            'elementid': {
                'type': 'string',
                'required': true
            },
            'height': {
                'type': 'string',
                'required': true
            },
            'width': {
                'type': 'string',
                'required': true
            }
        }
    }
}";
        /// <summary>
        /// New games are submitted to the website and database.
        /// </summary>
        /// <param name="archivePath">The full path to a game package archive.</param>
        /// <param name="userid">The userId of the Uploader.</param>
        /// <param name="name">The Games name.</param>
        /// <param name="description">The Games description.</param>
        /// <param name="tags">The Games tags.</param>
        /// <returns>A new instance of the Package.PackageInfo includes all properties.</returns>
        static public PackageInfo SubmitNewPackage(string archivePath, long userid, string name, string description, string[] tags, string[] categories, bool restricted)
        {
            PackageInfo packageConfig;
            using (ZipFile archive = ZipFile.Read(archivePath))
            {
                ZipEntry packageConfigEntry = archive["bearded-lama.json"];
                using (TextReader packageConfigReader = new StreamReader(packageConfigEntry.OpenReader()))
                {
                    packageConfig = ValidateConfiguration(packageConfigReader);
                }

                // Verify given configuration 'data' paths exist in the archive
                foreach (List<string> resourceGroup in packageConfig.Data.Values)
                {
                    foreach (string resource in resourceGroup)
                    {
                        if (!archive.ContainsEntry(resource))
                        {
                            throw new ZipException("Packaging error: " + resource + " not found in " + archive.Name + ".");
                        }
                    }
                }

                packageConfig.Name = name;
                packageConfig.Description = description;

                // insert new game information into db
                Access.NewGame(name, description, String.Join(",", tags), String.Join(",", categories), packageConfig.ToJsonString(), userid, restricted);
                long gameId = (long)new DataAccess.GamesTableAdapters.GamesTableAdapter().GetGameIdByGameName(name);
                packageConfig.Id = gameId.ToString();
                DataSets.Games.GamesRow gameRow = Access.GetGameById(gameId);
                gameRow.publicPackage = packageConfig.ToJsonString();
                Access.UpdateGame(gameRow); // update with newly minted games id

                // unpack game into Public/gameid/*
                string publicPath = Path.GetFullPath(ConfigurationManager.AppSettings["UploadPath"] + "/Public/" + gameId);
                foreach (List<string> resourceGroup in packageConfig.Data.Values)
                {
                    foreach (string resource in resourceGroup)
                    {
                        archive[resource].Extract(publicPath, ExtractExistingFileAction.OverwriteSilently);
                    }
                }
            }

            if (packageConfig == null)
            {
                throw new Exception("Validation failed: Package configuration found to be null.");
            }

            return packageConfig;
        }

        static private void ExtractPackageConfig(string archivePath)
        {

        }

        // Validate Game Package

        /// <summary>
        /// Initialises a new instance of the Package.PackageInfo class from the specified TextReader.
        /// </summary>
        /// <param name="jsonReader">TextReader for a JSON package, matching define schema.</param>
        /// <returns>A new instance of the Package.PackageInfo includes properties parsed successfully from the Json Configuration.</returns>
        /// <exception cref="JsonSchemaException">Contains schema validation messages in e.Data["validationMessages"]</exception>
        static public PackageInfo ValidateConfiguration(TextReader jsonReader)
        {
            using (JsonValidatingReader validatingReader = new JsonValidatingReader(new JsonTextReader(jsonReader)))
            {
                JsonSchema schema = JsonSchema.Parse(packageSchema);
                validatingReader.Schema = schema;
                IList<string> messages = new List<string>();
                validatingReader.ValidationEventHandler += (o, a) => messages.Add(a.Message);

                JsonSerializer serialiser = new JsonSerializer();
                PackageInfo deserialisedPackageInfo = serialiser.Deserialize<PackageInfo>(validatingReader);

                if (messages.Count != 0)
                {
                    JsonSchemaException e = new JsonSchemaException();
                    e.Data.Add("validationMessages", messages);
                    throw e;
                }
                else
                {
                    return deserialisedPackageInfo;
                }
            }
        }

        // Create Game Package
        // Update Game Package
        // Update Game Information
    }

    /// <summary>
    /// An instance of a deserialised json configuration, bearded-lama.json
    /// </summary>
    public class PackageInfo
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("identifier")]
        public string Id { get; set; }

        [JsonProperty("information")]
        public string Description { get; set; }

        [JsonProperty("instruction")]
        public string Instruction { get; set; }

        [JsonProperty("data")]
        public Dictionary<String, List<string>> Data { get; set; }

        [JsonProperty("entry")]
        public Dictionary<String, String> EntryPoint { get; set; }

        /// <summary>
        /// Returns an unindented JSON string of this PackageInfo instance.
        /// </summary>
        /// <returns>Unindented JSON string.</returns>
        public string ToJsonString()
        {
            return JsonConvert.SerializeObject(this, Formatting.None);
        }
    }
}
