@admin
Feature: Users modification CRUD

   Background: User creation from admin
    Given I have the Authorization header for administrator
      And I add a body request
       """
       {
           "_id":"",
           "actionTokens":{
              "maximumTokens":100,
              "usedTokens":0
           },
           "birthDate":"1994-10-10",
           "city":"dwdwdwdwdwd",
           "country":"American Samoa",
           "gender":"male",
           "name":"test new user",
           "password":"1234567890",
           "primaryEmail":"tadeoH_4_j@mail.xyz",
           "role":"user",
           "secondaryEmails":[

           ],
           "validated":True
        }
       """
    When I perform a POST  at the service "/admin/users"
      And I save the body response as "user_admin_response"
      And I get the "id" as "_id"
    Then I expect status code "201"

   @CRUD @delete_user @ENH
   Scenario: User modification from admin
     Given I have the Authorization header for administrator
      And I add a body request
       """
       {
          "_id":"_id",
          "name": "John Doe",
          "birthDate":"1994-10-25T04:00:00.000Z",
          "city":"Cochabamba",
          "country":"Bolivia",
          "gender":"male",
          "primaryEmail":"tadeoH_4_ej@mail.xyz",
          "role":"user",
          "secondaryEmails":[

          ],
          "validated":True,
          "actionTokens":{
             "maximumTokens":100,
             "usedTokens":0,
             "_id": ""
          }
       }
       """
    When I perform a PUT  at the service "/admin/users/{user_admin_response._id}"
      And I save the body response as "user_admin_response_put"
    Then I expect status code "200"
      And I verify the "user_admin_response_put" has a valid PUT schema
      And I verify the "user_admin_response_put" contains values sent on Request
      And I validate "user_admin_response_put" of service "users" with table "users" where "_id" is "user_admin_response._id"
      And I verify the "response" is contained in get_response at "/admin/users/{user_admin_response_put._id}" service


   @CRUD @ENH
   Scenario: Delete user from admin
     Given I have the Authorization header for administrator
     When I perform a DELETE  at the service "/admin/users/{user_admin_response._id}"
        And I save the body response as "delete_response"
     Then I expect status code "204"
     And I verify the "delete_response" has a valid DELETE schema

     Given I have the Authorization header for administrator
     When I perform a GET  at the service "/admin/users/{user_admin_response._id}"
        And I save the body response as "response"
    Then I expect status code "404"






