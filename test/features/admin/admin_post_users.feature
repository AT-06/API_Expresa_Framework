@admin
Feature: Users creation CRUD
   @CRUD @delete_user
   Scenario: : User creation from admin
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
           "primaryEmail":"morelia_mmherdnagni@mailto.xyz",
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
      And I verify the "user_admin_response" has a valid POST schema
      And I verify the "user_admin_response" contains values sent on Request
      And I validate "user_admin_response" of service "users" with table "users" where "_id" is "user_admin_response._id"
      And I verify the "response" is contained in get_response at "/admin/users/{user_admin_response._id}" service