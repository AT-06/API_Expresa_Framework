@Admin
Feature: Admin endpoint smoke test
  Background: example
    Given I have the Authorization header
    And I add a body request
      """
      {
        "_id":"",
        "name": "Test Admin",
        "birthDate":"1994-10-25T04:00:00.000Z",
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":"male",
        "password": "Pass123$",
        "primaryEmail":"ghills884@mailbox52.ga",
        "role":"user",
        "secondaryEmails":[

        ],
        "validated":True,
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
    And I add a body request
      """
      {
        "email": "ghills884@mailbox52.ga",
        "password": "Pass123$",
        "type":0
      }
      """
    When I perform a POST  at the service "/users/login"
    And I save the body response as "user_token"

  @Smoke
  Scenario: Perform admin smoke test
    Given I use "user_token.authToken" for Authorization header
    And I add a body request
    """
    {
        "_id":"",
        "name": "John Doe",
        "birthDate":"1994-10-25T04:00:00.000Z",
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":"male",
        "password": "Pass123$",
        "primaryEmail":"theo66782@mailbox87.de",
        "role":"user",
        "secondaryEmails":[

        ],
        "validated":True,
        "actionTokens":{
           "maximumTokens":100,
           "usedTokens":0
        }
    }
    """
    When I perform a POST  at the service "/admin/users"
    And I save the body response as "admin_response"
    Then I expect status code "201"
