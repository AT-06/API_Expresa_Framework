import simplejson as json

from core.database.utils.Util import Util
from jsonschema import exceptions
from jsonschema import validate
from core.utils.PropertiesManager import PropertiesManager

from core.responseBuilder.BuildResponseExpected import BuildResponseExpected

import os
class ResponseManager:
    def __init__(self, response):
        self.response = response

    def get_json_schema(self, service):

        with open(os.path.normpath(os.path.join(__file__, '../../../'))+self.get_schema_file(service), 'r') as f:
            schema_data = f.read()
        schema = json.loads(schema_data)
        return schema

    def validate_schema_response(self, service):
        service = service.split("/")
        build_service = "/{}/{}".format(service[1],service[-1])
        validate(self.response, self.get_json_schema(build_service))
        try:
            validate(self.response, self.get_json_schema(build_service))
            return True
        except exceptions.ValidationError:
            return False

    def get_schema_file(self, service):
        prop = PropertiesManager()
        path = prop.get_property("schemas", "path")
        return "{}{}.json".format(path,service)


    def validate_response_contain_body(self, body):
        builder = BuildResponseExpected()
        body = builder.build_response_json(body, self.response)
        response_iterate = Util()
        response_iterate.iterate_json(self.response)
        response_list = response_iterate.query_as_list

        body_iterate = Util()
        body_iterate.iterate_json(body)
        body_list = body_iterate.query_as_list

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


