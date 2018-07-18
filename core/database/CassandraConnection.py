from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider

class CassandraConnection:
    """Class to connect cassandra database"""

    __instance = None
    __session = None

    def __new__(cls, *args, **kwargs):
        if CassandraConnection.__instance is None:
            CassandraConnection.__instance = object.__new__(cls)
        return CassandraConnection.__instance

    def __init__(self):
        if CassandraConnection.__session is None:
            auth_provider = PlainTextAuthProvider(username = 'manuel', password = 'Pass123$')
            cluster = Cluster(["10.28.109.108"], auth_provider = auth_provider, port = 41497)
            CassandraConnection.__session = cluster.connect()
            CassandraConnection.__session.set_keyspace('manuel_keyspace')

    def get_connection(self):
        return CassandraConnection.__session

