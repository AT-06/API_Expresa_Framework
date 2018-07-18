import ast

from behave import given, when, then
from compare import expect

from core.request.ExecuteMethods import ExecuteMethods
from core.request.Utils import Utils

ex = ExecuteMethods()


@given(u'I have the Authorization header')
def step_impl(context):
    Utils.set_token(context.token)


@given(u'I add a body request')
def step_impl(context):
    ex.add_body(ast.literal_eval(context.text))


@when(u'I perform a {method}  at the service "{service}"')
def step_impl(context, method, service):
    context.service = service
    context.method = method
    context.end_point = Utils.build_end_point(context.url, context.service)
    context.response = ex.execute(context.method, context.end_point)


@when(u'I save the body response as "{service_name}"')
def step_impl(context, service_name):
    context.service_name = service_name
    Utils.save_response(context.service_name, context.response.json())


@then(u'I expect status code "{status_code}"')
def step_impl(context, status_code):
    context.status_code = status_code
    expect(context.response.status_code).to_equal(int(context.status_code))

@then(u'I get the "_id" as "$id" from ""')
def step_impl(context):
    print("********************************")

# Make this step generic for nested keys needed in tests
@given(u'I save "{key}" in "{variable}"')
def step_impl(context, key, variable):
    context.variable = variable
    context.key_needed = Utils.get_response_nested_value(key)
@when(u'I perform a {method} at the service "{service}"')
def step_impl(context, method, service):
    context.service = service.replace(context.variable, context.key_needed)
    context.method = method
    context.end_point = Utils.build_end_point(context.url, context.service)
    context.response = ex.execute(context.method, context.end_point)