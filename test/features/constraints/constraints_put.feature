Feature: Users creation CRUD
   Background: User creation
    Given I have the Authorization header
      And I add a body request
      """
      {
        "_id":"null",
        "name": "Test Admin JM",
        "birthDate":"1994-10-25T04:00:00.000Z",
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":"male",
        "password": "Pass123$",
        "primaryEmail":"eweeeteeeealeewr23sffdjgsulgowski827@mailbox87.de",
        "role":"user",
        "secondaryEmails":[

        ],
        "validated":False,
        "actionTokens":{
           "maximumTokens":100,
           "usedTokens":0
        }
      }
      """
    When I perform a POST  at the service "/users"
      And I save the body response as "user_response"
    Then I update the "role" to "admin" in "users" where "_id" is "user_response._id"
      And I update the "validated" to "true" in "users" where "_id" is "user_response._id"
    Given I add a body request
      """
      {
        "email": "eweeeteeeealeewr23sffdjgsulgowski827@mailbox87.de",
        "password": "Pass123$",
        "type":0
      }
      """
    When I perform a POST  at the service "/users/login"
      And I save the body response as "user_token"

    Given I use "user_token.authToken" for Authorization header
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

   Scenario: Put cost of last survey
      Given I use "user_token.authToken" for Authorization header
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

   Scenario: Get cost of last survey
      Given I use "user_token.authToken" for Authorization header
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



