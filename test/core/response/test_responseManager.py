from core.response.ResponseManager import *
from unittest import TestCase

class TestResponseManager(TestCase):
    def test_validate_response_contains_body(self):
        body = {"_id": "5b462c583ee20b60baf55762",
                "createdAt": "2018-12-12T00:00:00.000Z"
                }
        resp = {"_id": "5b462c583ee20b60baf55762",
                "registeredUsers": 19,
                "registeredSurveys": 2,
                "activeSurveys": 1,
                "createdAt": "2018-12-12T00:00:00.000Z"
                }
        a = ResponseManager(resp)
        self.assertTrue(a.validate_response_contains_body(body))


    def test_validate_response_not_contains_body(self):
        body = {"_id": "5b462c583ee20b60baf55762",
                "created": "2018-12-12T00:00:00.000Z"
                }
        resp = {"_id": "5b462c583ee20b60baf55762",
                "registeredUsers": 19,
                "registeredSurveys": 2,
                "activeSurveys": 1,
                "createdAt": "2018-12-12T00:00:00.000Z"
                }
        a = ResponseManager(resp)
        self.assertFalse(a.validate_response_contains_body(body))

    def test_validate_response_equals_body(self):
        body = {"_id": "5b462c583ee20b60baf55762",
                "registeredUsers": 19,
                "registeredSurveys": 2,
                "activeSurveys": 1,
                "createdAt": "2018-12-12T00:00:00.000Z"
                }
        resp = {"_id": "5b462c583ee20b60baf55762",
                "registeredUsers": 19,
                "registeredSurveys": 2,
                "activeSurveys": 1,
                "createdAt": "2018-12-12T00:00:00.000Z"
                }
        a = ResponseManager(resp)
        self.assertTrue(a.validate_response_equals_body(body))


    def test_validate_response_not_equals_body(self):
        body = {"_id": "5b462c583ee20b60baf55762",
                "createdAt": "2018-12-12T00:00:00.000Z"
                }
        resp = {"_id": "5b462c583ee20b60baf55762",
                "registeredUsers": 19,
                "registeredSurveys": 2,
                "activeSurveys": 1,
                "createdAt": "2018-12-12T00:00:00.000Z"
                }
        a = ResponseManager(resp)
        self.assertFalse(a.validate_response_equals_body(body))


