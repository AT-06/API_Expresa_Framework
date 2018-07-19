@users
Feature: Users creation CRUD

   @CRUD
   Scenario: : User creation
    Given I have the Authorization header
      And I add a body request
      """
      {
        "_id":"",
        "name": "Test Admin JM",
        "birthDate":"1994-10-25T04:00:00.000Z",
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":"male",
        "password": "Pass123$",
        "primaryEmail":"jgfulgowski827@mailbox87.de",
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
    Then I expect status code "201"
      And I verify the "user_response" has a valid POST schema
      And I verify the "user_response" contains values sent on Request

