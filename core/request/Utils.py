import re


class Utils:
    responses = {}
    token = ""

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
    def build_header():
        token = "Bearer {}".format(Utils.token)
        headers = {"Authorization": token}
        return headers

    @staticmethod
    def build_body(body, id):
        if body["_id"] != "":
            body["_id"] = id
            return body
        return body
