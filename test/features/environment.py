import yaml

global info_dict
generic_data = yaml.load(open('config/config.yml'))


def before_all(context):
    host = generic_data['connection']['host']
    port = generic_data['connection']['port']
    rootPath = generic_data['connection']['rootPath']

    context.url = "{}:{}{}".format(host, port, rootPath)
