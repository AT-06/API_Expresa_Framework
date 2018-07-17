import simplejson as json

from jsonschema import exceptions
from jsonschema import validate
from core.utils.PropertiesManager import PropertiesManager
from core.database.utils import Util

class ResponseManager:
    def __init__(self, response):
        self.response = response

    def get_json_schema(self, service):
        with open(self.get_schema_file(service), 'r') as f:
            schema_data = f.read()
        schema = json.loads(schema_data)
        return schema

    def validate_schema_response(self, service):
        validate(self.response, self.get_json_schema(service))
        try:
            validate(self.response, self.get_json_schema(service))
            return True
        except exceptions.ValidationError:
            return False

    def get_schema_file(self, service):
        prop = PropertiesManager()
        path = prop.get_property("schemas", "path")
        return "{}{}.json".format(path,service)


    def iterate_body(self, body):
        util_list = Util()
        util_list.iterate_json(self.response)
        response_list = util_list.query_as_list

        util_body = Util()
        util_body.iterate_json(body)
        body_list = util_body.query_as_list

        json_aux = {}
        for item_body in body_list:
            for item_resp in response_list:
                if item_body[1] == item_resp[1]:
                    if item_body[2] == item_resp[2]:
                        json_aux[item_body[0]+"_"+item_body[1]]= True
                        break
                    elif item_body[1] == "_id" and item_body[2] == "" or item_body[2] == "null":
                        json_aux[item_body[0] + "_" + item_body[1]] = True
                        break
                    elif item_body[1] == "password":
                        json_aux[item_body[0] + "_" + item_body[1]] = True
                        break
                    else: json_aux[item_body[0]+"_"+item_body[1]]= False

        if False in json_aux.values():
            return False
        return True

    def validate_response_equals_body(self, body):
        return sorted(body.items()) == sorted(self.response.items())


resp = {
    "__v": 0,
    "title": "test user 8/11/2018",
    "description": "test from normal user brand",
    "audience": 0,
    "settings": {
        "releaseDate": "2018-07-11T15:51:44.368Z",
        "expirationDate": "2018-07-15T15:51:44.366Z",
        "acceptMultipleAnswers": True,
        "allowIncognitoResponses": False,
        "showUsersEmail": False,
        "requiresLogIn": False,
        "_id": "5b47ad193ee20b60baf55f26",
        "allowedEmails": [],
        "allowedDomains": []
    },
    "state": 0,
    "creationDate": "2018-07-12T19:33:44.988Z",
    "responseQuantity": 0,
    "shortUrl": "",
    "actionTokensCost": 8,
    "fastpass": "",
    "owner": "5b47ac6d3ee20b60baf55efd",
    "_id": "5b47ad183ee20b60baf55f20",
    "questions": [
        {
            "text": "Survey 2 test by admin",
            "type": "checkbox",
            "required": False,
            "sequence": 0,
            "max": 0,
            "_id": "5b47ad193ee20b60baf55f21",
            "options": [
                {
                    "label": "option1",
                    "default": False,
                    "sequence": 0,
                    "_id": "5b47ad193ee20b60baf55f25"
                },
                {
                    "label": "option2",
                    "default": False,
                    "sequence": 1,
                    "_id": "5b47ad193ee20b60baf55f24"
                },
                {
                    "label": "option3",
                    "default": False,
                    "sequence": 2,
                    "_id": "5b47ad193ee20b60baf55f23"
                },
                {
                    "label": "option4",
                    "default": False,
                    "sequence": 3,
                    "_id": "5b47ad193ee20b60baf55f22"
                }
            ]
        }
    ],
    "tags": [
        "test ",
        "test2"
    ]
}
#a = ResponseManager(resp)
#print(a.validate_schema_response("/surveys/create"))

