Feature:Survey smoke tests

  Scenario:
    Given I have the Authorization header
    And I add a body request
     """
     {
         "_id":"",
         "title":"test 123456",
         "description":"test",
         "audience":0,
         "settings":{
            "releaseDate":"2018-06-29T15:51:44.368Z",
            "expirationDate":"2018-07-06T15:51:44.366Z",
            "allowedDomains":[],
            "acceptMultipleAnswers":True,
            "allowIncognitoResponses":False,
            "showUsersEmail":False,
            "allowedEmails":[],
            "requiresLogIn":False
         },
         "state":1,
         "creationDate":"2018-06-29T15:51:44.368Z",
         "responseQuantity":0,
         "questions":[
            {
               "_id":"",
               "text":"Name Question",
               "type":"signature",
               "required":False,
               "sequence":0,
               "valid":True,
               "max":0,
               "options":[],
               "wasTyped":True
            }
         ],
         "tags":[ ],
         "shortUrl":"",
         "actionTokensCost":0,
         "fastpass":""
     }
     """
    When I perform a POST  at the service "/surveys"
    And I save the body response as "survey_response"
    Then I expect status code "201"
    When I perform a DELETE  at the service "/surveys/{survey_response._id}"
    Then I expect status code "200"

#  Scenario Outline:Perform smoke test using GET method
#    Given I have the Authorization header
#    When I perform a GET  at the service "<Endpoint>"
#    Then I expect status code "200"
#
#
#    Examples:
#      | Endpoint                                         |
#      | /surveys                                         |
#      | /surveys/{survey_response._id}                   |
#      | /surveys/{survey_response._id}/edit              |
#      | /surveys/{survey_response._id}/overview          |
#      | /surveys/{survey_response._id}/results?type=json |
#      | /surveys/{survey_response._id}/results?type=csv  |





