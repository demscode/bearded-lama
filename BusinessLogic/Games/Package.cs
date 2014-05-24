using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Ionic.Zip;
using Newtonsoft.Json;
using Newtonsoft.Json.Schema;
using Newtonsoft.Json.Linq;

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
        // Submit Game Package

        // Validate Game Package

        /// <summary>
        /// Initialises a new instance of the Package.PackageInfo class from the specified TextReader.
        /// </summary>
        /// <param name="jsonReader">TextReader for a JSON package, matching define schema.</param>
        /// <returns></returns>
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
    }
}
