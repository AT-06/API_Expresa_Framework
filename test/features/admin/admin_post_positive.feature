@admin
Feature: Users creation CRUD
   @CRUD @delete_user
   Scenario Outline:  User creation from admin
    Given I have the Authorization header for administrator
      And I add a body request
       """
       {
           "_id":"",
           "actionTokens":{
              "maximumTokens":100,
              "usedTokens":0
           },
           "birthDate":<BIRTHDATE>,
           "city":<CITY>,
           "country":<COUNTRY>,
           "gender":<GENDER>,
           "name":<NAME>,
           "password":<PASSWORD>,
           "primaryEmail":<EMAIL>,
           "role":<ROLE>,
           "secondaryEmails":[

           ],
           "validated":<VALIDATED>
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
     Examples:
       | BIRTHDATE    | CITY     | COUNTRY   | GENDER   | NAME              | PASSWORD       | EMAIL                         | ROLE   | VALIDATED |
       | "1994-10-10" | "La paz" | "Bolivia" | "male"   | "Manuel vizcarra" | "Password123$" | "email_de_manuel@empresa.xwz" | "user" | True      |
       | "1994-10-10" | "SCZ"    | "BO"      | "female" | "eli"             | "123_pass"     | "short@test.wrs"              | "user" | False     |
       | "1994-10-10" | "valle de la luna | "estados unidos" | female" | "helena guzman  "  | "password12" | "xwq_oepr_er@mailto.xte" | "user" | True      |
       | "1994/10/10" | "La paz" | "Bolivia" | "male"   | "Manuel vizcarra" | "Password123$" | "email_de_manuel@empresa.xwz" | "user" | True      |


