import requests

from core.request.Utils import buildHeader, buildEndPoint


class ExecuteMethods:
    def __init__(self):
        self.methods = {"GET": self.executeGet,
                        "POST": self.executePost,
                        "PUT": self.executePut,
                        "DELETE": self.executeDelete
                        }

    def execute(self, method, endPoint, body):
        headers = buildHeader()
        return self.methods[method](endPoint, body, headers)

    def executeGet(self, endPoint, body, headers):
        return requests.get(endPoint, headers=headers)

    def executePost(self, endPoint, body, headers):
        return requests.post(endPoint, headers=headers, data=body)

    def executePut(self, endPoint, body, headers):
        return requests.put(endPoint, headers=headers, data=body)

    def executeDelete(self, endPoint, headers):
        return requests.delete(endPoint, headers=headers)

#################################################
# resp = ExecuteMethods()
# # service = "/constraints/survey"
# service = "/admin/users/{{USER_ID}}"
# body = {
#     "surveyCosts": {
#         "survey": 10,
#         "question": 3,
#         "publish": 5
#     }
# }
#
# main_url = buildEndPoint(service)
# r = resp.execute("GET", main_url, body)
# print(r.json())
# print("STATUS CODE:  ", r.status_code)
