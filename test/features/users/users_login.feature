Feature: Users endpoint smoke test
   Background: example
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
        "primaryEmail":"nnienow606@mailbox87.dexx",
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

  @Smoke
  Scenario: Perform users smoke test for service login
    Given I add a body request
      """
      {
        "email": "nnienow606@mailbox87.dexx",
        "password": "Pass123$",
        "type":0
      }
      """
    When I perform a POST  at the service "/users/login"
    And I save the body response as "user_token"




