@users
Feature: Users creation CRUD

   @CRUD
   Scenario: Get user with authorization token
    Given I have the Authorization header
    When I perform a GET  at the service "/users"
      And I save the body response as "user_response_get"
    Then I expect status code "200"
      And I verify the "user_response_get" has a valid GET schema
      And I verify the "user_response_get" contains values sent on Request
      And I validate "user_response_get" of service "users" with table "users" where "_id" is "user_response_get._id"