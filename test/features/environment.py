import yaml

global info_dict

generic_data = yaml.load(open("test/features/config/config.yml"))


def before_all(context):
    protocol = generic_data['connection']['protocol']
    host = generic_data['connection']['host']
    port = generic_data['connection']['port']
    rootPath = generic_data['connection']['rootPath']

    context.url = "{}://{}:{}{}".format(protocol, host, port, rootPath)
