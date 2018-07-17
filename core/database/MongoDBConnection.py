from pymongo import MongoClient


class MongoDBConnection(object):
    """Class to connect mongodb database"""

    __instance = None
    __client = None
    __db = None

    def __new__(cls, *args, **kwargs):
        if MongoDBConnection.__instance is None:
            MongoDBConnection.__instance = object.__new__(cls)
        return MongoDBConnection.__instance

    def __init__(self):
        if MongoDBConnection.__client is None:
            MongoDBConnection.__client = MongoClient('mongodb://manuel:Pass123$@10.28.109.108:14019/ixplora')
            MongoDBConnection.__db = MongoDBConnection.__client['ixplora']

    def get_connection(self):
        return MongoDBConnection.__db

       