


Feature: Not Create Survey With Invalid Inputs
  It could not be possible to create a survey with valid
  input from the body

  Scenario Outline: Create a survey invalid inputs
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
            "expirationDate":"2018-07-06T15:51:44.366Z",
            "allowedDomains":[],
            "acceptMultipleAnswers":<MULTIPLE_ANSWERS>,
            "allowIncognitoResponses":False,
            "showUsersEmail":False,
            "allowedEmails":[],
            "requiresLogIn":False
         },
         "state":<STATE>,
         "creationDate":"2018-06-29T15:51:44.368Z",
         "responseQuantity":<RESPONSE_QUANTITY>,
         "questions":[
            {
               "_id":"",
               "text":<QUESTION_NAME>,
               "type":<QUESTION_TYPE>,
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
         "actionTokensCost":<TOKEN_COST>,
         "fastpass":""
     }
     """
    When I perform a POST  at the service "/surveys"
    And I save the body response as "survey_response"
    Then I expect status code "400"

    Examples: Empty
      | TITLE           | RELEASE_DATE               | MULTIPLE_ANSWERS | STATE | RESPONSE_QUANTITY | QUESTION_NAME       | QUESTION_TYPE | TOKEN_COST |
      | ""              | "2018-06-29T15:51:44.368Z" | True             | 0     | 0                 | "Favorite Colors?"  | "signature"   | 0          |
      | "Survey Test 1" | ""                         | True             | 0     | 0                 | "Favorite Foods?"   | "checkbox"    | 0          |
      | "Survey Test 2" | "2018-06-29T15:51:44.368Z" | False            | 1     | 2                 | ""                  | "combobox"    | 0          |
      | "Survey Test 3" | "27187-15-288-:51:44.368Z" | False            | 1     | 2                 | "Orange or Banana?" | "combobox"    | 0          |
      | ""              | "2018-06-29T15:51:44.368Z" | True             | 0     | 0                 | "Favorite Colors?"  | "signature"   | 0          |
      | "Survey Test 4" | "2018-06-29T15:51:44.368Z" | True             | 0     | 1                 | "Popular Cities?"   | "signature"   | 5          |
      | "Survey Test 5" | "2018-06-29T15:51:44.368Z" | True             | 0     | 1                 | "Popular Cities?"   | ""            | 5          |

    Examples: Invalid
      | TITLE            | RELEASE_DATE               | MULTIPLE_ANSWERS | STATE | RESPONSE_QUANTITY | QUESTION_NAME      | QUESTION_TYPE | TOKEN_COST |
      | "Survey Test 6"  | "2018-06-29T15:51:44.368Z" | True             | 0     | 1                 | "Popular Cities?"  | "combobox"    | "Test"     |
      | "Survey Test 7"  | "2018-06-29T15:51:44.368Z" | 159              | 0     | 0                 | "Favorite Colors?" | "signature"   | 0          |
      | "Survey Test 8"  | "2018-06-29T15:51:44.368Z" | True             | 0     | "Verify"          | "Favorite Colors?" | "signature"   | 0          |
      | "Survey Test 9"  | "2018-06-29T15:51:44.368Z" | True             | True  | 8                 | "Favorite Colors?" | "signature"   | 0          |
      | "Survey Test 10" | "2018-06-29T15:51:44.368Z" | True             | 0     | 8                 | "Favorite Colors?" | "signature"   | False      |
      | "Survey Test 11" | "2018-06-29T15:51:44.368Z" | True             | 0     | 8                 | "Favorite Colors?" | "signature"   | False      |
      | 12               | "2018-06-29T15:51:44.368Z" | True             | 0     | 8                 | "Favorite Colors?" | "signature"   | 0          |
      | True             | "2018-06-29T15:51:44.368Z" | True             | 0     | 8                 | "Favorite Colors?" | "signature"   | 0          |
      | "Survey Test 13" | 2018                       | True             | 0     | 9                 | "Favorite Colors?" | "signature"   | 0          |
      | "Survey Test 14" | "2018-06-29T15:51:44.368Z" | True             | 0     | 5                 | True               | "signature"   | 0          |
      | "Survey Test 14" | "2018-06-29T15:51:44.368Z" | True             | 0     | 5                 | 123456             | "signature"   | 0          |

    Examples: Negative Inputs
      | TITLE         | RELEASE_DATE               | MULTIPLE_ANSWERS | STATE | RESPONSE_QUANTITY | QUESTION_NAME     | QUESTION_TYPE | TOKEN_COST |
      |               | "2018-06-29T15:51:44.368Z" | True             | 0     | 1                 | "Popular Cities?" | "combobox"    | "Test"     |
      | "Survey Test" |                            | False            | 0     | 1                 | "Popular Cities?" | "combobox"    | "Test"     |
      | "Survey Test" | "2018-06-29T15:51:44.368Z" |                  | 0     | 1                 | "Popular Cities?" | "combobox"    | "Test"     |
      | "Survey Test" | "2018-06-29T15:51:44.368Z" | False            |       | 1                 | "Popular Cities?" | "combobox"    | "Test"     |
      | "Survey Test" | "2018-06-29T15:51:44.368Z" | True             | 0     |                   | "Popular Cities?" | "combobox"    | "Test"     |
      | "Survey Test" | "2018-06-29T15:51:44.368Z" | True             | 0     | 1                 |                   | "combobox"    | "Test"     |
      | "Survey Test" | "2018-06-29T15:51:44.368Z" | False            | 0     | 1                 | "Popular Cities?" |               | "Test"     |
      | "Survey Test" | "2018-06-29T15:51:44.368Z" | True             | 0     | 1                 | "Popular Cities?" | "combobox"    |            |







