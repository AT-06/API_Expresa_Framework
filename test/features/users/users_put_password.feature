@users
Feature: Modification user password

   @CRUD
   Scenario: Modification user password
     Given I have the Authorization header
        And I add a body request
         """
         {
             "_id": "5b50afaa76917478e60fe03f",
             "oldPassword": "1234567890",
             "newPassword": "1234567890"
         }
         """
    When I perform a PUT  at the service "/users/password"
        And I save the body response as "password_response"
    Then I expect status code "200"
        And I verify the "password_response" has a valid PUT_PASSWORD schema
