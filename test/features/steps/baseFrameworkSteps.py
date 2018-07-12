from compare import expect
import requests


@given(u'I have a connection to "{url}"')
def step_impl(context, url):
    r = requests.get('http://10.28.109.113:4000/api/v1/health')
    print("STATUS CODE",r.status_code)
    print("TEXT",r.text)
    expect(True).to_equal(False)


