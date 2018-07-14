import simplejson as json
from jsonschema import exceptions
from jsonschema import validate

from core.utils.PropertiesManager import PropertiesManager


class ResponseManager:
    def __init__(self, response):
        self.response = response

    def get_json_schema(self, service):
        with open(self.get_schema_file(service), 'r') as f:
            schema_data = f.read()
        schema = json.loads(schema_data)
        return schema[service]

    def validate_schema_response(self, service):
        try:
            validate(self.response, self.get_json_schema(service))
            return True
        except exceptions.ValidationError:
            return False

    def get_schema_file(self, service):
        prop = PropertiesManager()
        root = "{}/{}/{}"
        path = prop.get_property("schemas", "path")
        file = prop.get_property("schemas", "name_file_schema")
        return root.format(path,service.split("/")[1],file)

    def validate_response_contains_body(self, body):

        if type(self.response) is dict:
            for (key, value) in self.response.items():

                if type(self.response[key]) is dict:
                    aux = self.response
                    self.response = self.response[key]
                    self.validate_response_contains_body(body)
                    self.response = aux
                if type(self.response[key]) is list:
                    aux = self.response
                    self.response = self.response[key]
                    self.validate_response_contains_body(body)
                    self.response = aux
                else: print(key," : ",value)


        if type(self.response) is list:
            for item in self.response:
                aux = self.response
                self.response = item #item = json
                self.validate_response_contains_body(body)
                self.response = aux


    def validate_response_equals_body(self, body):
        return sorted(body.items()) == sorted(self.response.items())




