Feature: Users actionTokens endpoint smoke test

  @Smoke
  Scenario: Perform users get validation with db for service users
    Given I have the Authorization header
    When I perform a GET  at the service "/users"
      And I save the body response as "users_response"
    Then I expect status code "200"
