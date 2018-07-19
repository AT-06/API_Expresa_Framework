@Users
Feature: Users endpoint smoke test

  @Smoke
  Scenario: Perform users smoke test for service login
    Given I add a body request
      """
      {
        "email": "dicki.aylin248@mailbox87.de",
        "password": "ixplora1233",
        "type":0
      }
      """
    When I perform a POST  at the service "/users/login"
      And I save the body response as "user_token"
    Then I expect status code "200"




