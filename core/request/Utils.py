import re


class Utils:
    responses = {}
    token = ""
    id = ""

    @staticmethod
    def build_end_point(url, service):
        build = []
        glue = "/"
        rootPaths = service.split("/")
        for i in range(1, len(rootPaths)):
            if re.match("^[{}]", rootPaths[i]):
                build.append(Utils.find_element(Utils.responses.get(Utils.name_responses(rootPaths[i])),
                                                Utils.key_element(rootPaths[i])))
            else:
                build.append(rootPaths[i])
        return "{}/{}".format(url, glue.join(build))

    @staticmethod
    def key_element(text):
        return text[text.find(".") + 1:text.find("}")]

    @staticmethod
    def name_responses(text):
        return text[text.find("{") + 1:text.find(".")]

    @staticmethod
    def find_element(response, id):
        return str(response[id])

    @staticmethod
    def save_response(name, response):
        # Utils.set_name(name)
        Utils.responses[name] = response

    @staticmethod
    def set_token(token):
        Utils.token = token

    @staticmethod
    def set_id(id):
        Utils.id = id

    @staticmethod
    def get_id():
        return Utils.id

    @staticmethod
    def build_header():
        token = "Bearer {}".format(Utils.token)
        headers = {"Authorization": token}
        return headers

    @staticmethod
    def get_response_value(name):
        response_name, field = name.split(".")
        return Utils.responses[response_name][field]

    @staticmethod
    def get_response_nested_value(name):
        response_name, parent, field = name.split(".")
        return Utils.responses[response_name][parent][field]

    @staticmethod
    def build_body(body, id):
        if "_id" in body:
            if body["_id"] == "_id":
                body["_id"] = id
                return body
        return body
