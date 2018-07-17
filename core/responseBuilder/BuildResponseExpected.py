class BuildResponseExpected:
    def __init__(self):
        self.id = "_id"

    def build_response_json(self, expected, response):
        '''This method build response json recursively'''
        build = {}
        for key_response, value_response in response.items():
            for key_expected, value_expected in expected.items():
                if key_expected == key_response and key_response != self.id:
                    build[key_expected] = self.evaluate_body(value_expected, value_response)
            if key_response not in build:
                build[key_response] = value_response
        return build

    def list_iterate(self, list, response):
        '''This method iterate if the expected and response are lists'''
        aux = []
        for value in range(len(list)):
            aux.append(self.evaluate_body(list[value], response[value]))
        return aux

    def evaluate_body(self, expected, response):
        '''This method evaluate if corresponds to dict or list and redirect it '''
        if self.verify_type_data(expected, response, dict):
            return self.build_response_json(expected, response)
        if self.verify_type_data(expected, response, list):
            return self.list_iterate(expected, response)
        return expected

    def verify_type_data(self, body, body_other, type):
        '''This method evaluate if both corresponds to the same data type '''
        return isinstance(body, type) and isinstance(body_other, type)

    def verify_get_post_response_jsons(self, get_response, post_response):
        '''This method compares two responses(get,post)if the post is contained in get '''
        for key_post, value_post in post_response.items():
            for key_get, value_get in get_response.items():
                if key_get == key_post:
                    if not self.evaluate_values(value_get, value_post):
                        return False
        return True

    def verify_get_post_list(self, get_body, post_body):
        '''This method compares two responses(get,post)if the post is contained in get(lists) '''
        for i in range(len(get_body)):
            if not self.evaluate_values(get_body[i], post_body[i]):
                return False
        return True

    def evaluate_values(self, value_get, value_post):
        '''This method compares the values of get and post are the same '''
        if value_get == value_post:
            return True
        if self.verify_type_data(value_get, value_post, dict):
            return self.verify_get_post_response_jsons(value_get, value_post)
        if self.verify_type_data(value_get, value_post, list):
            return self.verify_get_post_list(value_get, value_post)
        return False
