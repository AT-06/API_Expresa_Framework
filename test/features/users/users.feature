Feature: Users actionTokens endpoint smoke test

  @Smoke
  Scenario: Perform users get validation with db for service users
    Given I have the Authorization header
    When I perform a GET  at the service "/users"
      And I save the body response as "users_response"
    Then I expect status code "200"

  @Negative
  Scenario Outline: Perform users negative test with invalid token
    Given I have an invalid "<AUTHORIZATION>" header
    When I perform a GET  at the service "/users"
     And I save the body response as "users_negative"
    Then I expect status code "401"
     And I verify the response "users_negative" with the following body
     """
     {
        "details": "Not Authorize to continue",
        "statusCode": 401
     }
     """
    Examples:
      | AUTHORIZATION                |
      | 498798-*45-*6/-45646-45*6/-* |
      | popl\zpxp\x56+654++6         |