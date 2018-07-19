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

  @Negative
  Scenario Outline: Perform users negative test for service actionTokens
    Given I have the Authorization header
    When I perform a GET  at the service "/users/<USER_ID>/actionTokens"
    Then I expect status code "404"
    Examples: Invalid
      | USER_ID                     |
      | "5b50907076917478e60fdeZ8"  |

  @Negative
  Scenario Outline: Perform users negative test with invalid token for service actionTokens
    Given I have an invalid "<AUTHORIZATION>" header
    When I perform a GET  at the service "/users/{users_response._id}/actionTokens"
    Then I expect status code "401"
    Examples:
      | AUTHORIZATION                |
      | 498798-*45-*6/-45646-45*6/-* |
      | popl\zpxp\x56+654++6         |