import ast

from behave import then
from compare import expect

from core.request.ExecuteMethods import ExecuteMethods
from core.request.Utils import Utils
from core.response.ResponseManager import ResponseManager
from core.responseBuilder.BuildResponseExpected import BuildResponseExpected

ex = ExecuteMethods()
build = BuildResponseExpected()


@then(u'I verify the "{response}" has a valid {schema} schema')
def step_impl(context, schema, response):
    context.schema = schema.lower()
    resp = ResponseManager(Utils.responses.get(response))
    expect(resp.validate_schema_response("{}/{}".format(context.service, context.schema))).to_be_truthy()


@then(u'I verify the "{response}" contains values sent on Request')
def step_impl(context, response):
    resp = ResponseManager(Utils.responses.get(response))
    expect(resp.validate_response_contain_body(ex.get_body())).to_be_truthy()


@then(u'I expect status code "{status_code}"')
def step_impl(context, status_code):
    context.status_code = status_code
    expect(context.response.status_code).to_equal(int(context.status_code))


@then(u'I verify the "response" is contained in get_response at "{service}" service')
def step_impl(context, service):
    context.end_point_get = Utils.build_end_point(context.url, service)
    context.get_response = ex.execute('GET', context.end_point_get).json()
    expect(build.verify_get_post_response_jsons(context.get_response, context.response.json())).to_be_truthy()


@then(u'I verify the response "{response}" with the following body')
def step_impl(context, response):
    resp = ResponseManager(Utils.responses.get(response))
    expect(resp.validate_response_contain_body(ast.literal_eval(context.text))).to_be_truthy()
