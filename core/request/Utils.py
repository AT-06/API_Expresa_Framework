import re


def buildEndPoint(service):
    url = "http://10.28.109.113:4000/api/v1"  # get global URL
    id = "5b464c76d9889619d66366ba"  # a Get Method
    build = []
    glue = "/"
    rootPaths = service.split("/")
    for i in range(1, len(rootPaths)):
        if re.match("^[{}\[\]]", rootPaths[i]):
            build.append(id)
        else:
            build.append(rootPaths[i])
    print("{}/{}".format(url, glue.join(build)))
    return "{}/{}".format(url, glue.join(build))


def buildHeader():
    auth_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1YjQ2NGM3NmQ5ODg5NjE5ZDY2MzY2YmEiLCJlbWFpbCI6InN3ZWxjaDU0MkBtYWlsYm94NTIuZ2EiLCJyb2xlIjoiYWRtaW4iLCJleHBpcmF0aW9uRGF0ZSI6IjIwMTgtMDctMjVUMjA6NTE6MjAuNzExWiIsImlhdCI6MTUzMTM0MjI4MH0.Dq-avWRpASCXPF-8rR4o3LF7By5qF4B38Miz8nUsSJs"
    token = "Bearer {}".format(auth_token)
    headers = {"Authorization": token}
    return headers
