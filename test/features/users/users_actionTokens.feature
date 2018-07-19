Feature: Users actionTokens endpoint smoke test
   Background: example
    Given I have the Authorization header
    When I perform a GET  at the service "/users"
      And I save the body response as "users_response"

  @Smoke
  Scenario: Perform users smoke test for service actionTokens
    Given I have the Authorization header
    When I perform a GET  at the service "/users/{users_response._id}/actionTokens"
    Then I expect status code "200"



