class BuildResponseExpected:
    def __init__(self):
        self.id = "_id"

    def build_response_json(self, expected, response):
        '''This method build response json recursively'''
        build = {}
        for key_response, value_response in response.items():
            for key_expected, value_expected in expected.items():
                if key_expected == key_response and key_response != self.id:
                    build[key_expected] = self.evaluate(value_expected, value_response)
            if key_response not in build:
                build[key_response] = value_response
        return build

    def list_iterate(self, list, response):
        '''This method iterate if the expected and response are lists'''
        aux = []
        for value in range(len(list)):
            aux.append(self.evaluate(list[value], response[value]))
        return aux

    def evaluate(self, expected, response):
        '''This method evaluate if corresponds to dict or list and redirect it '''
        if isinstance(expected, dict) and isinstance(response, dict):
            return self.build_response_json(expected, response)
        if isinstance(expected, list) and isinstance(response, list):
            return self.list_iterate(expected, response)
        return expected
