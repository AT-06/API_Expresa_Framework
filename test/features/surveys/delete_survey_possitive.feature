Feature: Delete a survey and get the survey deleted

  Background:
    Given I have the Authorization header
    And I add a body request
     """
     {
         "_id":"",
         "title":"Delete delete",
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
         "state":0,
         "creationDate":"2018-06-29T15:51:44.368Z",
         "responseQuantity":0,
         "questions":[
            {
               "_id":"",
               "text":"DELETE",
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

  @possible
  Scenario:Delete survey
    Given I have the Authorization header
    When I perform a DELETE  at the service "/surveys/{survey_response._id}"
    Then I expect status code "200"
    And I perform a GET  at the service "/surveys/{survey_response._id}"
    And I expect status code "404"
