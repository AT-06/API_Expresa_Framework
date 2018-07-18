import yaml
from core.request.Utils import Utils
from core.request.ExecuteMethods import ExecuteMethods

ex = ExecuteMethods()
global info_dict

generic_data = yaml.load(open("test/features/config/config.yml"))
generic_data_user = yaml.load(open("test/features/config/user_credential.yml"))


def before_all(context):
    protocol = generic_data['connection']['protocol']
    host = generic_data['connection']['host']
    port = generic_data['connection']['port']
    rootPath = generic_data['connection']['rootPath']
    context.token = generic_data_user['credential']['token']
    context._id = None
    context.url = "{}://{}:{}{}".format(protocol, host, port, rootPath)


def after_scenario(context, scenario):
    if 'delete_item' in scenario.tags:
        context.endpoint_surveys = "{}/{}".format("/surveys", context._id)
        build_endpoint = Utils.build_end_point(context.url, context.endpoint_surveys)
        response = ex.execute('DELETE', build_endpoint)
