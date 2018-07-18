import ast
from behave import then
from compare import expect
from core.request.ExecuteMethods import ExecuteMethods
from core.request.Utils import Utils
from core.database.DBManager import DBManager

ex = ExecuteMethods()
db = DBManager()

@then(u'I update the "{field}" to "{field_value}" in "{table}" where "{where_field}" is "{where_value}"')
def step_impl(context, field, field_value, table, where_field, where_value):
    context.field = field
    context.field_value = field_value
    context.table = table
    context.where_field = where_field
    context.where_value = where_value
    db.update_mongo_db(context.table, {context.field: context.field_value}, context.where_field, Utils.get_response_value(context.where_value), context.mongo_connection)

@given(u'I use "{token}" for Authorization header')
def step_impl(context, token):
    context.token = token
    Utils.set_token(Utils.get_response_value(context.token))

