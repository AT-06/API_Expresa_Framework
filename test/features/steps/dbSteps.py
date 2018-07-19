import ast
from behave import then
from compare import expect
from core.request.ExecuteMethods import ExecuteMethods
from core.request.Utils import Utils
from core.database.utils.Util import Util as db_util
from core.database.DBManager import DBManager

ex = ExecuteMethods()
db = DBManager()
db_util = db_util()

@then(u'I update the "{field}" to "{field_value}" in "{table}" where "{where_field}" is "{where_value}"')
def step_impl(context, field, field_value, table, where_field, where_value):
    context.field = field
    context.field_value = field_value
    context.table = table
    context.where_field = where_field
    context.where_value = where_value
    context.user_id = Utils.get_response_value(context.where_value)
    Utils.set_id(context.user_id)
    db.update_mongo_db(context.table, {context.field: context.field_value}, context.where_field, context.user_id, context.mongo_connection)

@step(u'I validate "{response}" of service "{service}" with table "{table}" where "{field}" is "{field_value}"')
def step_impl(context, response, table, field, field_value, service):
    context.field = field
    context.field_value = field_value
    context.table = table
    query = db.select_mongo_db(context.table, context.field, Utils.get_response_value(field_value), context.mongo_connection)
    get_equals_query = db_util.query_response(context.response.json(), query, service)
    expect(get_equals_query).to_be_truthy()

@given(u'I use "{token}" for Authorization header')
def step_impl(context, token):
    context.token = token
    Utils.set_token(Utils.get_response_value(context.token))

