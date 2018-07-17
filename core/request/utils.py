import re


class Utils:
    responses = {}

    def __init__(self):
        pass

    @staticmethod
    def build_end_point(url, service):
        build = []
        glue = "/"
        rootPaths = service.split("/")
        for i in range(1, len(rootPaths)):
            if re.match("^[{}]", rootPaths[i]):
                build.append(Utils.find_element(Utils.get_response, "_id"))
            else:
                build.append(rootPaths[i])
        return "{}/{}".format(url, glue.join(build))

    @classmethod
    def find_element(response, id):
        return response[id]

    def save_response(self, response):
        self.responses = response

    def get_response(self):
        return self.responses

    # response = {
    #     "_id": "5b466926d9889619d663674b",
    #     "title": "Copia de test 123",
    #     "description": "Check the popular colors",
    #     "audience": 0,
    #     "settings": {
    #         "releaseDate": "2018-07-10T15:25:44.368Z",
    #         "expirationDate": "2018-07-11T15:51:44.366Z",
    #         "allowedEmails": [],
    #         "allowedDomains": [],
    #         "_id": "5b4cc084d3acca1b6e1f8298"
    #     },
    #     "state": 2,
    #     "creationDate": "2018-07-16T17:57:30.162Z",
    #     "responseQuantity": 0,
    #     "actionTokensCost": 13,
    #     "fastpass": "",
    #     "tags": [
    #         "test ",
    #         "test2"
    #     ]
    # }
    # return response

    @staticmethod
    def build_header():
        auth_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1YjQ2NGM3NmQ5ODg5NjE5ZDY2MzY2YmEiLCJlbWFpbCI6InN3ZWxjaDU0MkBtYWlsYm94NTIuZ2EiLCJyb2xlIjoiYWRtaW4iLCJleHBpcmF0aW9uRGF0ZSI6IjIwMTgtMDctMjVUMjA6NTE6MjAuNzExWiIsImlhdCI6MTUzMTM0MjI4MH0.Dq-avWRpASCXPF-8rR4o3LF7By5qF4B38Miz8nUsSJs"
        token = "Bearer {}".format(auth_token)
        headers = {"Authorization": token}
        return headers
