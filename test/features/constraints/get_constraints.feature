@Constraints
Feature: Users creation CRUD

   Background: Survey creation
    Given I have the Authorization header for administrator
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

    Given I have the Authorization header for administrator
        And I add a body request
         """
         {
	        "surveyCosts":{
	          "survey": 5,
	          "question": 6,
	          "publish": 7
	        }
         }
         """
    When I perform a PUT  at the service "/constraints/survey"
    Then I expect status code "200"

   @CRUD @delete_item
   Scenario: Get cost of last survey
      Given I have the Authorization header for administrator
      When I perform a GET  at the service "/constraints/survey"
          And I save the body response as "constraints_response"
      Then I expect status code "200"
          And I verify the "constraints_response" has a valid GET schema
          And I verify the "constraints_response" contains values sent on Request
          And I validate "constraints_response" of service "constraints" with table "survey_costs" where "_id" is "constraints_response._id"



