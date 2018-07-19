@users
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
        "primaryEmail":"23sffdjgsulgowski827@mailbox87.de",
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
      And I update the "validated" to "true" in "users" where "_id" is "user_response._id"

    Given I add a body request
      """
      {
        "email": "23sffdjgsulgowski827@mailbox87.de",
        "password": "Pass123$",
        "type":0
      }
      """
    When I perform a POST  at the service "/users/login"
       And I save the body response as "user_token"
    Then I expect status code "200"

   @CRUD
   Scenario: Get user with authorization token
    Given I use "user_token.authToken" for Authorization header
    When I perform a GET  at the service "/users"
      And I save the body response as "user_response_get"
    Then I expect status code "200"
      And I verify the "user_response_get" has a valid GET schema
      And I verify the "user_response_get" contains values sent on Request
      And I validate "user_response_get" of service "users" with table "users" where "_id" is "user_response_get._id"