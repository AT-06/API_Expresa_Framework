class BuildResponseExpected:
    def __init__(self):
        self.id = "_id"

    def build_response_json(self, expected, response):
        '''This method build response json recursively'''
        response_aux = response
        for key in response.copy():
            for i in expected.copy():
                if i == key:
                    if self.verify_not_is_dictionary_list(expected[i]):
                        if i != self.id:
                            response_aux[i] = expected[i]
                    else:
                        response[i] = self.evaluate_body(expected[i], response[i])
        return response_aux

    def build_response_list(self, expected, response):
        '''This method redirect the build response in case that exist a list'''
        response_aux = response
        for i in range(len(expected)):
            if type(response[i]) is dict and type(expected[i]) is dict:
                response_aux[i] = self.build_response_json(expected[i], response[i])
            else:
                if expected[i] not in response:
                    response_aux.append(expected[i])
        return response_aux

    def evaluate_body(self, expected, response):
        '''This method evaluate if the expected is a list or dic and redirect '''
        if type(expected) is dict:
            return self.build_response_json(expected, response)
        elif type(expected) is list:
            return self.build_response_list(expected, response)

    def verify_not_is_dictionary_list(self, value):
        '''This method evaluate that the value isn't a dic or list'''
        return type(value) is not dict and type(value) is not list
