@Constraints
Feature: Constraints endpoint smoke test

  @Smoke
  Scenario: Perform constraints smoke test for maximumTokens
    Given I have the Authorization header
    When I perform a GET  at the service "/constraints/maximumTokens"
    Then I expect status code "200"
