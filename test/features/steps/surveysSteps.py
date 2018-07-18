import ast

from behave import given, when, then
from compare import expect

from core.request.ExecuteMethods import ExecuteMethods
from core.request.utils import Utils
from core.response.ResponseManager import ResponseManager

ex = ExecuteMethods()

@then(u'I verify the "{response}" has a valid {schema} schema')
def step_impl(context, schema, response):
 context.schema = schema.lower()
 resp = ResponseManager(Utils.responses.get(response))
 expect(resp.validate_schema_response("{}/{}".format(context.service,context.schema))).to_equal(True)