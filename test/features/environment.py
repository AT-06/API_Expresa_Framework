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
