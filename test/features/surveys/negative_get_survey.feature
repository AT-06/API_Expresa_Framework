Feature: Not Create Survey With Invalid Token
  It could not be possible to create a survey with invalid
  token authorization from the headers

  Scenario Outline: Perform a GET surveys with an invalid token
    Given I have an invalid "<Authorization>" header
    When I perform a GET  at the service "/surveys"
    Then I expect status code "401"
    Examples:
      | Authorization                |
      | 498798-*45-*6/-45646-45*6/-* |
      | popl\zpxp\x56+654++6         |

  Scenario: Perform a GET surveys without surveys inside the account
    Given I have the Authorization header
    When I perform a GET  at the service "/surveys"
    Then I expect status code "200"



