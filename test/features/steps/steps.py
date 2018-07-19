import ast

from core.request.ExecuteMethods import ExecuteMethods
from core.request.Utils import Utils

ex = ExecuteMethods()


@given(u'I have the Authorization header')
def step_impl(context):
    Utils.set_token(context.token)


@given(u'I add a body request')
def step_impl(context):
    body_evaluate = Utils.build_body(ast.literal_eval(context.text), context._id)
    ex.add_body(body_evaluate)


@when(u'I perform a {method}  at the service "{service}"')
def step_impl(context, method, service):
    context.service = service
    context.method = method
    context.end_point = Utils.build_end_point(context.url, context.service)
    context.response = ex.execute(context.method, context.end_point)


@when(u'I get the "id" as "{value}"')
def step_impl(context, value):
    context._id = context.response.json()[value]


@when(u'I save the body response as "{service_name}"')
def step_impl(context, service_name):
    context.service_name = service_name
    Utils.save_response(context.service_name, context.response.json())
