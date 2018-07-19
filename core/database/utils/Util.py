import simplejson as json
from core.database.DBManager import *
from bson.objectid import ObjectId
from core.database.resources.users_get_relations import relation as user_relation
from core.database.resources.surveys_get_relation import relation as survey_relation
from core.database.resources.constraints_get_relation import relation as constraints_relation
from datetime import datetime

class Util:

    def __init__(self):
        self.template = {}
        self.query_as_list = []

    def query_response(self, template, query_result, service):
        # db = DBManager()
        # query_result = db.select_mongo_db(table, field, primary_key)
        # with open("../../../resources/{}_get.json".format(file_name)) as file:
        #     json_file = file.read()
        self.template = template
        self.iterate_json(query_result)
        query_final = self.query_as_list
        self.query_as_list = []
        self.iterate_json(self.template)
        response_final = self.query_as_list
        self.query_as_list = []
        if service == "users":
            self.iterate_json(user_relation)
        elif service == "surveys":
            self.iterate_json(survey_relation)
        elif service == "constraints":
            self.iterate_json(constraints_relation)
        relation_list = self.query_as_list
        return self.change_relation(query_final, response_final, relation_list)

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

    def change_relation(self, query_final, response_final, relation_list):
        query_final.sort(key=lambda sublist: sublist[0])
        query_final.sort(key=lambda sublist: sublist[1])

        response_final.sort(key=lambda sublist: sublist[0])
        response_final.sort(key=lambda sublist: sublist[1])

        relation_list.sort(key=lambda sublist: sublist[0])
        relation_list.sort(key=lambda sublist: sublist[1])

        new_query = []
        for i in range(len(query_final)):
            if not self.is_list_in_response(query_final[i], response_final):
                keys_relation = self.is_list_in_relation(query_final[i], relation_list)
                if keys_relation:
                    query_final[i][1] = keys_relation
                if self.is_list_in_response(query_final[i], response_final):
                    new_query.append(query_final[i])
            else:
                new_query.append(query_final[i])
        new_query.sort(key=lambda sublist: sublist[0])
        new_query.sort(key=lambda sublist: sublist[1])
        return new_query == response_final

    def is_list_in_response(self, list, response):
        for i in range(len(response)):
            if response[i] == list:
                return True
            elif type(list[2]) == datetime:
                list[2] = str(list[2]).replace(" ", "T")
                if len(list[2]) < 20:
                    list[2] = str(list[2]) + ".000Z"
                else:
                    list[2] = list[2][0:23] + "Z"
                if response[i] == list:
                    return True
            if list[2] == "true":
                list[2] = bool(list[2])
                if response[i] == list:
                    return True
        return False

    def is_list_in_relation(self, list, relation):
        for i in range(len(relation)):
            if relation[i][0] == list[0] and relation[i][1] == list[1]:
                return relation[i][2]
        return False


# util = Util()
# util.query_response("users", "users", "_id", "5b43d066d743a132a883d135")



