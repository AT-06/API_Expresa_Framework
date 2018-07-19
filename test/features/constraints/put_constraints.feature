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

   @CRUD @delete_item
   Scenario: Put cost of last survey
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




