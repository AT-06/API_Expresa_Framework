import simplejson as json
from core.database.DBManager import *
from core.database.resources.users_get_relations import relation

class Util:

    def build_get_response(self):
        query_as_body = {}
        db = DBManager()
        query_result = db.select_mongo_db("survey_costs", "_id", "5b3fed3cd743a132a883d11e")
        with open("../resources/users_get.json") as file:
            json_file = file.read()
        template = json.loads(json_file)
        for (key, value) in template.items():
            query_as_body[key] = query_result[key]

util = Util()
util.build_get_response()