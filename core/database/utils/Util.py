import simplejson as json
from core.database.DBManager import *
from bson.objectid import ObjectId
from core.database.resources.users_get_relations import relation
from bson.json_util import dumps

class Util:

    def __init__(self):
        self.template = {}
        self.query_as_list = []


    def query_response(self):
        db = DBManager()
        query_result = db.select_mongo_db("users", "_id", "5b43d066d743a132a883d135")
        with open("../resources/users_get.json") as file:
            json_file = file.read()
        self.template = json.loads(json_file)
        self.iterate_json(query_result)
        query_final = self.query_as_list
        self.query_as_list = []
        self.iterate_json(self.template)
        response_final = self.query_as_list
        self.query_as_list = []
        self.iterate_json(relation)
        relation_list = self.query_as_list
        # print(query_final)
        # print(response_final)
        # print(relation_list)
        # return query_final

    def iterate_json(self, json1, key = "", previous_key = ""):
        if type(json1) == dict:
            for k, v in json1.items():
                self.iterate_json(v, k, key)
        if type(json1) == list:
            if len(json1) < 1:
                self.build_get_response(key, json1, previous_key)
            for x in json1:
                self.iterate_json(x, key, key)
        elif type(json1) != dict and type(json1) != list:
            self.build_get_response(key, json1, previous_key)

    def build_get_response(self, key, value, previous_key):
        new_data = []
        if previous_key == "":
            previous_key = "main"
        new_data.append(previous_key)
        new_data.append(key)
        if type(value) == ObjectId:
            value = str(value)
        new_data.append(value)
        self.query_as_list.append(new_data)


util = Util()
util.query_response()


