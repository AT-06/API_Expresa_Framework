@admin
Feature: Get user by id from administrator

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

   @CRUD  @delete_user
   Scenario: Get user by id
     Given I have the Authorization header for administrator
     When I perform a GET  at the service "/admin/users/{user_admin_response._id}"
        And I save the body response as "response"
    Then I expect status code "200"
        And I verify the "user_admin_response" has a valid GET schema
        And I validate "response" of service "admin" with table "users" where "_id" is "user_admin_response._id"
