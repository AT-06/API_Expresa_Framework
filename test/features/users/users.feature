Feature: Users actionTokens endpoint smoke test
   Background: example
    Given I have the Authorization header
    And I add a body request
      """
      {
        "_id":"null",
        "name": "Test Admin JMVV",
        "birthDate":"1994-10-25T04:00:00.000Z",
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":"male",
        "password": "Pass123$",
        "primaryEmail":"maymie18965@mailbox87.de",
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
    Then I update the "validated" to "true" in "users" where "_id" is "user_response._id"
    Given I add a body request
      """
      {
        "email": "maymie18965@mailbox87.de",
        "password": "Pass123$",
        "type":0
      }
      """
    When I perform a POST  at the service "/users/login"
    And I save the body response as "user_token"

  @Smoke
  Scenario: Perform users smoke test for service users
    Given I use "user_token.authToken" for Authorization header
    When I perform a GET  at the service "/users"
    Then I expect status code "200"

  @Smoke
  Scenario: Perform users get validation with db for service users
    Given I use "user_token.authToken" for Authorization header
    When I perform a GET  at the service "/users"
    And I save the body response as "users_response"
    Then I expect status code "200"
    And I validate "users_response" of service "users" with table "users" where "_id" is "user_response._id"
