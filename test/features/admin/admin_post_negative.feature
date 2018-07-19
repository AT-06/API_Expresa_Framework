@admin
Feature: Create user with normal user token

  @Negative @delete_user
   Scenario: : User creation with user token
    Given I have the Authorization header
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
    Then I expect status code "403"
        And I verify the response "user_admin_response" with the following body
         """
         {
            "details": "You are not allowed to perform this action",
            "statusCode": 403
         }
         """


   @Negative @delete_user
   Scenario: : User creation with an existent email
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
           "primaryEmail":"test@lambda.xwz",
           "role":"user",
           "secondaryEmails":[

           ],
           "validated":True
        }
       """
    When I perform a POST  at the service "/admin/users"
      And I save the body response as "user_admin_response_email"
    Then I expect status code "409"
        And I verify the response "user_admin_response_email" with the following body
         """
         {
            "statusCode": 409,
            "details": "Email address is already taken, please try another one",
            "payload": None
         }
         """


   @Negative @delete_user
   Scenario Outline: : User creation with different values
    Given I have the Authorization header for administrator
      And I add a body request
      """
      {
           "_id":"",
           "actionTokens":{
              "maximumTokens":<MAXIMUM_TOKENS>,
              "usedTokens":<USED_TOKENS>
           },
           "birthDate":"<BIRTHDATE>,
           "city":<CITY>,
           "country":<COUNTRY>,
           "gender":<GENDER>,
           "name":<NAME>,
           "password":<PASSWORD>,
           "primaryEmail":<PRIMARY_EMAIL>,
           "role":<ROLE>,
           "secondaryEmails":[

           ],
           "validated":<VALIDATED>
      }
      """
    When I perform a POST  at the service "/admin/users"
      And I save the body response as "user_admin_response"
      And I get the "id" as "_id"
    Then I expect status code "400"
      And I verify the response "user_admin_response" with the following body
      """
      {
          "statusCode": 400,
          "details": "Invalid request",
          "payload": None
      }
      """
    Examples: Empty

        | MAXIMUM_TOKENS  | USED_TOKENS | BIRTHDATE      | CITY        | COUNTRY   | GENDER     | NAME          | PASSWORD                  | ROLE      |PRIMARY_EMAIL       | VALIDATED  |
        | 100             |  0          | None           | "Coch"      | "Bo"      | "female"   | "signature"   | "123456789nvbnv5645ytyryr"| "user"    |"helena_34@mail.yre"| False      |
        | 100             |  0          | None           | "Cochabamba"| "Bolivia" | "female"   | "signature"   | "123456789nvbnv5645ytyryr"| "user"    |"helena_34@mail.yre"| False      |
        | 100             |  0          | None           | "Cochabamba"| "Bolivia" | "female"   | "signature"   | "123456789nvbnv5645ytyryr"| "user"    |"helena_34@mail.yre"| False      |
        | 100             |  0          | ""             | ""          | ""        | "female"   | "signature"   | "123456789nvbnv5645ytyryr"| True      |"helena_34@mail.yre"| False      |
        | 100             |  0          | 8              | ""          | ""        | 5          | "signature"   | ""                        | ""        |"helena_34@mail.yre"| ""         |
        | 100             |  0          | 8              | ""          | ""        | 5          | "signature"   | ""                        | ""        |"helena_34@mail.yre"| ""         |
        | 100             |  0          | "test"         | ""          | "BO"      | 5          | "/%[]Mery"    | "123456789"               | ""        |"helena_34@mail.yre"| ""         |
        | 100             |  0          | 800            | "Coch"      | ""        | ""         | "signature"   | "12345678912345l6789"     | ""        |"helena_34@mail.yre"| "True"     |
        | 100             |  0          | "test"         | "Coch"      | ""        | "male"     | "/%[]Mery"    | ""                        | ""        |"helena_34@mail.yre"| "False"    |
        | 100             |  0          | "1994-10-10"   | ""          | ""        | "female"   | "/%[]Mery"    | ""                        | "admin"   |"helena_34@mail.yre"| 44         |
        | 100             |  0          | None           | ""          | "Bolivia" | True       | "signature"   | ""                        | "user"    |"helena_34@mail.yre"| ""         |
        | 100             |  0          | 88             | ""          | "Bolivia" | True       | ""            | "12345678912345l6789"     | "user"    |"helena_34@mail.yre"| ""         |
        | 100             |  0          | "A-Z"          | ""          | "Bolivia" | True       | ""            | "12345678912345l6789"     | ""        |"helena_34@mail.yre"| "test"     |
        | 100             |  0          | "2018-02-30"   | ""          | "Bolivia" | True       | ""            | "12345678912345l6789"     | ""        |"helena_34@mail.yre"| "test"     |
        | 100             |  0          | "2028-02-02"   | ""          | "Bolivia" | True       | ""            | "12345678912345l6789"     | ""        |"helena_34@mail.yre"| "test"     |




