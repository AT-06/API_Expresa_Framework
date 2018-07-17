import re


class Utils:
    responses = {}
    token = ""
    name = ""

    def __init__(self):
        pass

    @staticmethod
    def build_end_point(url, service):
        build = []
        glue = "/"
        rootPaths = service.split("/")
        for i in range(1, len(rootPaths)):
            if re.match("^[{}]", rootPaths[i]):
                build.append(Utils.find_element(Utils.responses.get(Utils.get_name()), "_id"))
            else:
                build.append(rootPaths[i])
        return "{}/{}".format(url, glue.join(build))

    @staticmethod
    def find_element(response, id):
        return str(response[id])

    @staticmethod
    def save_response(name, response):
        Utils.set_name(name)
        Utils.responses[name] = response

    @staticmethod
    def set_name(name):
        Utils.name = name

    @staticmethod
    def get_name():
        return Utils.name

    @staticmethod
    def set_token(token):
        Utils.token = token

    @staticmethod
    def build_header():
        #     auth_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1YjQ2NGM3NmQ5ODg5NjE5ZDY2MzY2YmEiLCJlbWFpbCI6InN3ZWxjaDU0MkBtYWlsYm94NTIuZ2EiLCJyb2xlIjoiYWRtaW4iLCJleHBpcmF0aW9uRGF0ZSI6IjIwMTgtMDctMjVUMjA6NTE6MjAuNzExWiIsImlhdCI6MTUzMTM0MjI4MH0.Dq-avWRpASCXPF-8rR4o3LF7By5qF4B38Miz8nUsSJs"
        #     token = "Bearer {}".format(auth_token)
        #     headers = {"Authorization": token}
        headers = {"X-TrackerToken": Utils.token}
        return headers
