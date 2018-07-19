Feature: Verify that is not possible update a survey with invalid data

  Background:
    Given I have the Authorization header
    And I add a body request
     """
     {
         "_id":"",
         "title":"negative",
         "description":"test",
         "audience":0,
         "settings":{
            "releaseDate":"2018-06-29T15:51:44.368Z",
            "expirationDate":"2018-07-06T15:51:44.366Z",
            "allowedDomains":[],
            "acceptMultipleAnswers":True,
            "allowIncognitoResponses":False,
            "showUsersEmail":False,
            "allowedEmails":[],
            "requiresLogIn":False
         },
         "state":0,
         "creationDate":"2018-06-29T15:51:44.368Z",
         "responseQuantity":0,
         "questions":[
            {
               "_id":"",
               "text":"Name Question",
               "type":"signature",
               "required":False,
               "sequence":0,
               "valid":True,
               "max":0,
               "options":[],
               "wasTyped":True
            }
         ],
         "tags":[ ],
         "shortUrl":"",
         "actionTokensCost":0,
         "fastpass":""
     }
     """
    When I perform a POST  at the service "/surveys"
    And I save the body response as "survey_response"
    And I get the "id" as "_id"
    Then I expect status code "201"

  @negative @delete_item
  Scenario Outline: Update survey invalid data
    Given I have the Authorization header
    And I add a body request
     """
     {
         "_id":"",
         "title":<TITLE>,
         "description":"test",
         "audience":0,
         "settings":{
            "releaseDate":<RELEASE_DATE>,
            "expirationDate":<EXPIRATION_DATE>,
            "allowedDomains":<ALLOWED_DOMAIN>,
            "acceptMultipleAnswers":False,
            "allowIncognitoResponses":False,
            "showUsersEmail":<SHOW_EMAIL>,
            "allowedEmails":<ALLOWED_EMAIL>,
            "requiresLogIn":False
         },
         "state":<STATE>,
         "creationDate":<CREATION_DATE>,
         "responseQuantity":0,
         "questions":[
            {
               "_id":"",
               "text":"QUESTION",
               "type":<QUESTION_TYPE>,
               "required":False,
               "sequence":0,
               "valid":True,
               "max":0,
               "options":[],
               "wasTyped":True
            }
         ],
         "tags":<TAGS>,
         "shortUrl":"",
         "actionTokensCost":<TOKEN_COST>,
         "fastpass":<FASTPASS>
     }
     """
    When I perform a PUT  at the service "/surveys/{survey_response._id}"
    And I save the body response as "response"
    Then I expect status code "400"
    And I verify the response "response" with the following body
    """
    {
      "statusCode": 400,
      "details": "Invalid request",
      "payload": None
    }
    """
    Examples: Invalid Inputs
      | TITLE    | RELEASE_DATE               | EXPIRATION_DATE               | CREATION_DATE                | ALLOWED_DOMAIN | STATE | QUESTION_TYPE | TAGS      | TOKEN_COST | FASTPASS | ALLOWED_EMAIL        | SHOW_EMAIL
      | "TITLE"  | "2018-06-29T15:51:44.368Z" | "2000-06-29T15:51:44.368Z"    | "9999-06-29T15:51:44.368Z"   | []             | 0     | "signature"   | []        | 10         | ""       | []                   | False      |
      | ""       | "*******"                  | "......"                      | "88888--06-29T15:51:44.368Z" | [""]           | 1     | "freetext"    | ["test"]  | 5          | "1111"   | []                   | True       |
      | "other"  | "2018-06-29T15:51:44.368Z" | "2018-06-29T15:51:44.368Z"    | "2018-06-29T15:51:44.368Z"   | ["invalid"]    | 0     | "checkbox"    | []        | 10         | "0000"   | ["invalid_email"]    | False      |
      | "TITLE"  | "5555-06-29T15:51:44.368Z" | "2018-06-29T15:51:44.368Z"    | "2018-06-29T15:51:44.368Z"   | []             | 0     | "HOLAAAA"     | []        | 5          | "....."  | []                   | True       |
      | "NOT"    | "2018-06-29T15:51:44.368Z" | "5-06-29T15:51:44.368Z"       | "2015-06-29T15:51:44.368Z"   | [""]           | 0     | "OTHER"       | ["S","S"] | 10         | ""       |                      | falsss     |
      | 4455     | "2018-06-29T15:51:44.368Z" | "2000-06-29T15:51:44.368Z"    | "9999-06-29T15:51:44.368Z"   | 12222          | 0     | "signature"   | [""]      | 10         | "-----"  | []                   | True       |
      | "TITLE"  | 551102                     | "2100-06-29T15:51:44.368Z"    | "1111-06-29T15:51:44.368Z"   | [123]          | 0     | "option"      | []        | 3          | ""       | [4555]               | True       |
      | "_____"  | "2018-06-29T15:51:44.368Z" | "15155-1515-29T15:51:44.368Z" | "9999-06-29T15:51:44.368Z"   | []             | 0     | "signature"   | []        | 10         | ""       | []                   | 5555525221 |
      | "TITLE"  | 551102                     | "2000-06-29T15:51:44.368Z"    | "1111-06-29T15:51:44.368Z"   | [123]          | 0     | "option"      | []        | 3          | ""       | [4555]               | True       |
      | "*+*958" | ""                         | ""                            | ""                           | []             | 0     | "invented"    | []        | 3          | "valid"  | ["hola@gmail.com22"] | False      |

