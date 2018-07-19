Feature: Must not to GET a Survey State with invalid inputs
  The feature must not to get a request with invalid inputs
  at the service /surveys/{id-survey}/sharedWith


  Background:Create a new survey
    Given I have the Authorization header
    And I add a body request
     """
     {
         "_id":"",
         "title":"PUT SURVEY SHARED WITH",
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

  @delete_item
  Scenario: Perform a PUT surveys shared with with an invalid token
    Given I have the Authorization header
    And I add a body request
    """
    [
       {
          "userEmail":"test_at06@mail.com",
          "showUserInfo":True,
          "rights":[
             0,
             1
          ]
       }
    ]
    """
    When I perform a PUT  at the service " /surveys/{survey_response._id}/sharedWith"
    Then I expect status code "201"
    And I save the body response as "response"







