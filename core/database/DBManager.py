from core.database.MongoDBConnection import MongoDBConnection
from core.database.CassandraConnection import CassandraConnection
from bson.objectid import ObjectId
import uuid

class DBManager:
    """Class to connect and make queries to databases, mongodb - cassandra"""


    def select_mongo_db(self, table, field, field_value, connection):
        """Method to select a single record from database.
        `table` is the table document from record will be retrieved.
        `field` is the field to filter records.
        `field_value` is the value to match."""
        self.conn = MongoDBConnection(connection)
        db = self.conn.get_connection()
        collections = db[table]
        result = collections.find_one({field: ObjectId(field_value)})
        return result

    def update_mongo_db(self, table, fields_values, where_field, where_value, connection):
        """Method to update a single record from database.
        `table` is the table document from record will be retrieved.
        `field` is the field to update records.
        `field_value` is the value to update in the field.
        `where_value` is the value to filter"""

        self.conn = MongoDBConnection(connection)
        db = self.conn.get_connection()
        collections = db[table]
        result = collections.update_one({where_field: ObjectId(where_value)}, {"$set": fields_values})
        return result

    def delete_mongo_db(self, table, where_field, where_value, connection):
        """Method to update a single record from database.
        `table` is the table document from record will be retrieved.
        `field` is the field to update records.
        `field_value` is the value to update in the field.
        `where_value` is the value to filter"""

        self.conn = MongoDBConnection(connection)
        db = self.conn.get_connection()
        collections = db[table]
        result = collections.delete_one({where_field:ObjectId(where_value)})
        # result = collections.delete_many({})
        return result

    def select_cassandra(self, table, field, field_value):
        """Method to select a single record from database.
        `table` is the table document from record will be retrieved.
        `field` is the field to filter records.
        `field_value` is the value to match (most of the cases primary key)."""

        self.conn = CassandraConnection()
        session = self.conn.get_connection()
        query = "SELECT * FROM {} WHERE {}=%s".format(table, field)
        rows = session.execute(query, [uuid.UUID('{}'.format(field_value))])
        print(list(rows))

