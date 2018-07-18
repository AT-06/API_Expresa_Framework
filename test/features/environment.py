import yaml

global info_dict

generic_data = yaml.load(open("test/features/config/config.yml"))
generic_data_user = yaml.load(open("test/features/config/user_credential.yml"))


def before_all(context):
    protocol = generic_data['connection']['protocol']
    host = generic_data['connection']['host']
    port = generic_data['connection']['port']
    rootPath = generic_data['connection']['rootPath']
    context.token = generic_data_user['credential']['token']

    context.url = "{}://{}:{}{}".format(protocol, host, port, rootPath)

    # DB
    mongo_host = generic_data['mongodb']['mongo_host']
    mongo_user = generic_data['mongodb']['mongo_user']
    mongo_password = generic_data['mongodb']['mongo_password']
    mongo_port = generic_data['mongodb']['mongo_port']
    mongo_db_name = generic_data['mongodb']['mongo_db_name']

    context.mongo_connection = "mongodb://{}:{}@{}:{}/{}".format(mongo_user, mongo_password, mongo_host, mongo_port,
                                                                 mongo_db_name)
    cassandra_host = generic_data['cassandradb']['cassandra_host']
    cassandra_user = generic_data['cassandradb']['cassandra_user']
    cassandra_password = generic_data['cassandradb']['cassandra_password']
    cassandra_port = generic_data['cassandradb']['cassandra_port']
    cassandra_keyspace = generic_data['cassandradb']['cassandra_keyspace']

    context.cassandra_connection = [cassandra_host, cassandra_user, cassandra_password, cassandra_port,
                                    cassandra_keyspace]
