@users
Feature: Users creation CRUD

   @CRUD
   Scenario: : User creation
    Given I have the Authorization header
      And I add a body request
      """
      {
        "_id":"",
        "name": "Test Admin JM",
        "birthDate":"1994-10-25T04:00:00.000Z",
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":"male",
        "password": "Pass123$",
        "primaryEmail":"jgfulgowski666@mailbox87.de",
        "role":"user",
        "secondaryEmails":[

        ],
        "validated":False,
        "actionTokens":{
           "maximumTokens":100,
           "usedTokens":0
        }
      }
      """
    When I perform a POST  at the service "/users"
      And I save the body response as "user_response"
    Then I expect status code "201"
      And I verify the "user_response" has a valid POST schema
      And I verify the "user_response" contains values sent on Request

   @Negative
   Scenario Outline: : User negative creation
    Given I have the Authorization header
      And I add a body request
      """
      {
        "_id":"",
        "name": <NAME>,
        "birthDate":<BIRTHDATE>,
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":<GENDER>,
        "password": <PASSWORD>,
        "primaryEmail":<PRIMARYEMAIL>,
        "role":<ROLE>,
        "secondaryEmails":[

        ],
        "validated":<VALIDATED>,
        "actionTokens":{
           "maximumTokens":<MAXTOKENS>,
           "usedTokens":<USEDTOKENS>
        }
      }
      """
    When I perform a POST  at the service "/users"
      And I save the body response as "user_response"
    Then I expect status code "400"
     And I verify the response "user_response" with the following body
     """
     {
        "statusCode": 400,
        "details": "Invalid request",
        "payload": None
     }
     """
    Examples: Empty
      | NAME         | BIRTHDATE                  | GENDER   | PASSWORD | PRIMARYEMAIL          | ROLE    | VALIDATED | MAXTOKENS | USEDTOKENS |
      | ""           | ""                         | "female" | ""       | ""                    | "admin" | False     | 1         | 1          |
      | "Valid Name" | ""                         | "female" | "123$"   | "knowmauikl@mail.com" | "users" | False     | 1         | 1          |
      | "Valid Name" | "1994-10-30T04:00:00.000Z" | ""       | "89777$" | "knowmauikl@mail.com" | "admin" | False     | 1         | 1          |
      | "Valid Name" | "1994-10-30T04:00:00.000Z" | "male"   | ""       | "knowmauikl@mail.com" | "users" | True      | 0         | 0          |
      | "Valid Name" | "1994-10-30T04:00:00.000Z" | "male"   | "6464$A" | ""                    | "admin" | True      | 0         | 1          |
      | "Valid Name" | "1994-10-30T04:00:00.000Z" | "male"   | "6464$A" | "kno.8549kl@mail.com" | ""      | True      | 0         | 1          |
      | "Valid Name" | "1994-10-30T04:00:00.000Z" | "male"   | "6464$A" | "kno.8549kl@mail.com" | "admin" |           | 1         | 0          |

    Examples: Invalid
      | NAME         | BIRTHDATE                  | GENDER   | PASSWORD | PRIMARYEMAIL          | ROLE    | VALIDATED | MAXTOKENS | USEDTOKENS |
      | "Valid Name" | ""                         | "female" | ""       | ""                    | "admin" | False     | 1         | 1          |
      | "Valid Name" | "1994-10-30T04:00:00.000Z" | "female" | "Pass123"| "emaiil.246@mail.com" | "roles" | 0         | 1         | 1          |
      | "Valid Name" | "1994-10-30T04:00:00.000Z" | "female" | "Pass123"| "emaiil.246@mail.com" | "admin" | 0         | 1         | 1          |
      | "1234687898" | "1994-10-50T04:00:00.000Z" | "gender" | "Pass123"| "emaiil.246.mail.com" | "roles" | True      | -1        | -1         |

   @Negative
   Scenario Outline: : User creation with existing mail
    Given I have the Authorization header
      And I add a body request
      """
      {
        "_id":"",
        "name": "Valid Name",
        "birthDate":"1994-10-30T04:00:00.000Z",
        "city":"Cochabamba",
        "country":"Bolivia",
        "gender":"female",
        "password": "123$",
        "primaryEmail":"kturner332@mailbox87.de",
        "role":"user",
        "secondaryEmails":[

        ],
        "validated":False,
        "actionTokens":{
           "maximumTokens":0,
           "usedTokens":0
        }
      }
      """
    When I perform a POST  at the service "/users"
      And I save the body response as "user_response"
    Then I expect status code "409"
     And I verify the response "user_response" with the following body
     """
     {
        "statusCode": 409,
        "details": "Email address is already taken, please try another one",
        "payload": null
     }
     """
