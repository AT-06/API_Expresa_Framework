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
           "role":"admin",
           "secondaryEmails":[

           ],
           "validated":True
        }
       """
    When I perform a POST  at the service "/admin/users"
      And I save the body response as "user_admin_response"
      And I get the "id" as "_id"
    Then I expect status code "201"

   @Smoke @delete_user
   Scenario: Login administrator
     Given I have the Authorization header for administrator
      And I add a body request
       """
       {
           "email":"tadeoH_4_j@mail.xyz",
           "password":"1234567890",
           "type":0
       }
       """
    When I perform a POST  at the service "/admin/users/login"
      And I save the body response as "user_admin_response_login"
    Then I expect status code "200"




