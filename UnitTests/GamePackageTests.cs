using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using BusinessLogic.Games;
using Newtonsoft.Json.Schema;
using System.IO;

namespace UnitTests
{
    [TestClass]
    public class GamePackageTests
    {
        // TEST RESOURCES

        private string validIncompleteJsonString = @"
{
    'data': {
        'js': [
            '/bin/game.js',
            '/bin/levels.js'
        ]
    },
    'entry': {
        'element': 'canvas',
        'id': 'gameEntry',
        'height': '400',
        'width': '600'
    }
}";
        private string validCompleteJsonString = @"
{
    'name': 'coolGame',
    'identifier': '1',
    'information': 'This game includes graphic violence.',
    'instruction': 'Press q to quit',
    'data': {
        'js': [
            '/bin/game.js',
            '/bin/levels.js'
        ]
    },
    'entry': {
        'element': 'canvas',
        'id': 'gameEntry',
        'height': '400',
        'width': '600'
    }
}";
        private string invalidJsonString = @"
{
    'name': 'coolGame',
    'identifier': '1',
    'information': 'This game includes graphic violence.',
    'instruction': 'Press q to quit',
    'entry': {
        'element': 'canvas',
        'id': 'gameEntry',
        'height': '400',
        'width': '600'
    }
}";

        // TESTS

        [TestMethod]
        public void TestValidIncompletePackageInfoValidation()
        {
            PackageInfo validPackageInfo = Package.ValidateConfiguration(new StringReader(validIncompleteJsonString));
            Assert.IsNotNull(validPackageInfo);
        }

        [TestMethod]
        public void TestValidCompletePackageInfoValidation()
        {
            PackageInfo validPackageInfo = Package.ValidateConfiguration(new StringReader(validCompleteJsonString));
            Assert.IsNotNull(validPackageInfo);
        }

        [TestMethod]
        [ExpectedException(typeof(Newtonsoft.Json.Schema.JsonSchemaException))]
        public void TestInvalidPackageInfoValidation()
        {
            PackageInfo invalidPackageInfo = Package.ValidateConfiguration(new StringReader(invalidJsonString));
            Assert.IsNull(invalidPackageInfo);
        }
    }
}
