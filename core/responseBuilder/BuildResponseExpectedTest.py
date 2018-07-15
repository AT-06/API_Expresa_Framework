from unittest import TestCase
from core.responseBuilder.BuildResponseExpected import BuildResponseExpected


class BuildResponseExpectedTest(TestCase):
    def setUp(self):
        self.build = BuildResponseExpected()

    def test_a(self):
        expected = {"id_user": "", "user": "Escarleth", "age": 5, "numbers": {"uno": 1},
                    "prueba": {"dic": {"q1": "555"}},
                    "test": [{"a": 1, "d": {1: 1, "si": [2, {3: 3}]}, "x": {"b": 999}}]}

        response = {"user": "Escar", "age": 15, "numbers": {"uno": 11, "dos": 2, "id": 89999}, "version": 7270,
                    "year": 12,
                    "prueba": {"dic": {"q1": "1", "id": 12345}},
                    "test": [{"a": 2, "d": {1: 2, "si": [2, {3: 4, 5: 5}]}, "x": {"b": 2}}]}

        answer = {"user": "Escarleth", "age": 5, "numbers": {"uno": 1, "dos": 2, "id": 89999}, "version": 7270,
                  "year": 12,
                  "prueba": {"dic": {"q1": "555", "id": 12345}},
                  "test": [{"a": 1, "d": {1: 1, "si": [2, {3: 3, 5: 5}]}, "x": {"b": 999}}]}
        self.assertEqual(self.build.build_response_json(expected, response), answer)

    def test_create(self):
        expected = {
            "_id": "",
            "title": "Prueba",
            "description": "Testing API",
            "audience": 90,
            "settings": {
                "releaseDate": "2020-06-29T15:51:44.368Z",
                "expirationDate": "2020-07-06T15:51:44.366Z",
                "allowedDomains": [
                    "test",
                    "test2", "test3"],
                "acceptMultipleAnswers": False,
                "allowIncognitoResponses": True,
                "showUsersEmail": True,
                "allowedEmails": [],
                "requiresLogIn": False
            },
            "state": 1,
            "creationDate": "2020-06-29T15:51:44.368Z",
            "responseQuantity": 0,
            "questions": [
                {
                    "_id": "",
                    "text": "QUESTION1",
                    "type": "checkbox",
                    "required": True,
                    "sequence": 70,
                    "valid": True,
                    "max": 0,
                    "options": [
                        {
                            "_id": "",
                            "label": "ANSWER1",
                            "default": True,
                            "sequence": 15,
                            "isValid": True
                        }, {
                            "_id": "",
                            "label": "ANSWER2",
                            "default": False,
                            "sequence": 2,
                            "isValid": False
                        }
                    ],
                    "wasTyped": True
                }],
            "tags": [
                "test ",
                "test2", "test3"
            ],
            "shortUrl": "",
            "actionTokensCost": 10000000,
            "fastpass": "5555"
        }

        response = {
            "__v": 0,
            "title": "Response",
            "description": "Response",
            "audience": 0,
            "settings": {
                "releaseDate": "2000-06-29T15:51:44.368Z",
                "expirationDate": "2000-07-06T15:51:44.366Z",
                "acceptMultipleAnswers": True,
                "allowIncognitoResponses": False,
                "showUsersEmail": False,
                "requiresLogIn": False,
                "_id": "5b47bf2f3ee20b60baf560dc",
                "allowedEmails": [],
                "allowedDomains": ["test",
                                   "test2", "test3"]
            },
            "state": 2,
            "creationDate": "2000-07-12T20:50:55.025Z",
            "responseQuantity": 0,
            "shortUrl": "",
            "actionTokensCost": 8,
            "fastpass": "11111",
            "owner": "5b465bad3ee20b60baf55785",
            "_id": "5b47bf2f3ee20b60baf560d6",
            "questions": [
                {
                    "text": "ResponseQuestion",
                    "type": "checkbox",
                    "required": False,
                    "sequence": 0,
                    "max": 0,
                    "_id": "5b47bf2f3ee20b60baf560d7",
                    "options": [
                        {
                            "label": "Option1",
                            "default": False,
                            "sequence": 0,
                            "_id": "11111"
                        }, {
                            "label": "Option2",
                            "default": False,
                            "sequence": 0,
                            "_id": "2222"
                        }]}],
            "tags": [
                "test ", "test2", "id"]
        }
        build = {"__v": 0,
                 "title": "Prueba",
                 "description": "Testing API",
                 "audience": 90,
                 "settings": {
                     "releaseDate": "2020-06-29T15:51:44.368Z",
                     "expirationDate": "2020-07-06T15:51:44.366Z",
                     "acceptMultipleAnswers": False,
                     "allowIncognitoResponses": True,
                     "showUsersEmail": True,
                     "requiresLogIn": False,
                     "_id": "5b47bf2f3ee20b60baf560dc",
                     "allowedEmails": [],
                     "allowedDomains": ["test",
                                        "test2", "test3"]
                 },
                 "state": 1,
                 "creationDate": "2020-06-29T15:51:44.368Z",
                 "responseQuantity": 0,
                 "shortUrl": "",
                 "actionTokensCost": 10000000,
                 "fastpass": "5555",
                 "owner": "5b465bad3ee20b60baf55785",
                 "_id": "5b47bf2f3ee20b60baf560d6",
                 "questions": [
                     {
                         "text": "QUESTION1",
                         "type": "checkbox",
                         "required": True,
                         "sequence": 70,
                         "max": 0,
                         "_id": "5b47bf2f3ee20b60baf560d7",
                         "options": [
                             {
                                 "label": "ANSWER1",
                                 "default": True,
                                 "sequence": 15,
                                 "_id": "11111"
                             }, {
                                 "label": "ANSWER2",
                                 "default": False,
                                 "sequence": 2,
                                 "_id": "2222"
                             }]}],
                 "tags": [
                     "test ",
                     "test2", "id", "test3"]
                 }
        self.assertEqual(self.build.build_response_json(expected, response), build)