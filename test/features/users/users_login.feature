@Users
Feature: Users endpoint smoke test

  @Smoke
  Scenario: Perform users smoke test for service login
    Given I have the Authorization header
      And I add a body request
      """
      {
        "email": "brook23259@mailbox92.biz",
        "password": "Pass123$",
        "type":0
      }
      """
    When I perform a POST  at the service "/users/login"
     And I save the body response as "user_token"
    Then I expect status code "200"


  @Negative
  Scenario Outline: Perform users login with invalid body request
    Given I have the Authorization header
      And I add a body request
      """
      {
        "email": <EMAIL>,
        "password": <PASSWORD>,
        "type":<TYPE>
      }
      """
    When I perform a POST  at the service "/users/login"
      And I save the body response as "user_token"
    Then I expect status code "401"
     And I verify the response "user_token" with the following body
     """
     {
        "statusCode": 401,
        "details": "Invalid email or password",
        "payload": None
     }
     """
    Examples: Invalid
      | EMAIL                       | PASSWORD   | TYPE |
      | "brook23259@mailbox92.biz"  | "Pass123"  | 0    |
      | "brook23259@mailbox91.biz"  | "Pass123"  | 0    |
      | "brook23259@mailbox91.biz"  | "Pass123$" | 0    |