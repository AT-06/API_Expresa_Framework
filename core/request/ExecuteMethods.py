import requests

from core.request.utils import Utils


class ExecuteMethods:
    def __init__(self):
        self.body = {}
        self.methods = {"GET": self.execute_get,
                        "POST": self.execute_post,
                        "PUT": self.execute_put,
                        "DELETE": self.execute_delete
                        }

    def execute(self, method, endPoint):
        headers = Utils.build_header()
        return self.methods[method](endPoint, headers) if (method == "GET" or method == "DELETE") else self.methods[
            method](endPoint, self.get_body(), headers)

    def execute_get(self, endPoint, headers):
        return requests.get(endPoint, headers=headers)

    def execute_post(self, endPoint, body, headers):
        return requests.post(endPoint, headers=headers, data=body)

    def execute_put(self, endPoint, body, headers):
        return requests.put(endPoint, headers=headers, data=body)

    def execute_delete(self, endPoint, headers):
        return requests.delete(endPoint, headers=headers)

    def add_body(self, body):
        self.body = body

    def get_body(self):
        return self.body


