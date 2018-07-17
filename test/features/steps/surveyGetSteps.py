import ast
import json

from behave import given, when, then
from compare import expect

from core.request.ExecuteMethods import ExecuteMethods
from core.request.utils import Utils

ex = ExecuteMethods()


@given(u'a survey')
def step_impl(context):
    print(context.url)


@given(u'I add the body ')
def step_impl(context):
    ex.add_body(ast.literal_eval(context.text))


@when(u'I want to do a {method} on a "{service}"')
def step_impl(context, service, method):
    context.service = service
    context.method = method
    context.end_point = Utils.build_end_point(context.url, context.service)
    context.response = ex.execute(context.method, context.end_point)
    expect(context.response.status_code).to_equal(int(200))


@then(u'I can verify the status code {code}')
def step_impl(context, code):
    context.code = code
    expect(200).to_equal(int(code))
