from compare import expect

from core.request import ExecuteMethods
from core.request.Utils import buildEndPoint

ex = ExecuteMethods


@given(u'I have a connection to "{service}"')
def step_impl(context, service):
    context.service = service
    context.endPoint = buildEndPoint(context.url, context.service)


@when(u'I get {method}')
def step_impl(context, method):
    context.method = method
    body = ""
    context.response = ex.execute(context.method, context.endPoint, body)


@then(u'I can check the status code {statusCode}')
def step_impl(context, statusCode):
    context.statusCode = statusCode
    expect(context.response).to_equal(int(context.statusCode))
