Feature: Verify that is not possible update update a survey when was open(state1)
  closed(state 2)

  Background:
    Given I have the Authorization header
    And I add a body request
     """
     {
         "_id":"",
         "title":"negative",
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
    And I get the "id" as "_id"
    Then I expect status code "201"

  @negative @delete_item
  Scenario Outline:Update a survey when was opened
    Given I have the Authorization header
    And I add a body request
     """
     {
         "_id":"_id",
         "title":<TITLE>,
         "description":"updating",
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
         "state":<STATE>,
         "creationDate":"2018-06-29T15:51:44.368Z",
         "responseQuantity":0,
         "questions":[
            {
               "_id":"",
               "text":<QUESTION>,
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
    When I perform a PUT  at the service "/surveys/{survey_response._id}"
    And I save the body response as "response"
    Then I expect status code "400"
    And I verify the response "response" with the following body
    """
    {
      "statusCode": 400,
      "details": "Survey title and questions shouldn't be edited when survey is running or closed",
      "payload": None
    }
    """
    Examples:
      | TITLE         | QUESTION          | STATE |
      | "negative"    | "change question" | 0     |
      | "Other title" | "Other question"  | 1     |
