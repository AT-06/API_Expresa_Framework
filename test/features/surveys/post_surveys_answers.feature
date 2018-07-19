@Surveys
Feature: Verify the creation of a survey's answers

  Background: Create a new survey
    Given I have the Authorization header
      And I add a body request
      """
      {
           "_id":"",
           "title":"test",
           "description":"test",
           "audience":0,
           "settings":{
              "releaseDate":"2018-06-29T15:51:44.368Z",
              "expirationDate":"2018-07-25T15:51:44.366Z",
              "allowedDomains":[

              ],
              "acceptMultipleAnswers":True,
              "allowIncognitoResponses":False,
              "showUsersEmail":False,
              "allowedEmails":[

              ],
              "requiresLogIn":False
           },
           "state":1,
           "creationDate":"2018-06-29T15:51:44.368Z",
           "responseQuantity":0,
           "questions":[
              {
                 "_id":"",
                 "text":"Name Question",
                 "type":"checkbox",
                 "required":False,
                 "sequence":0,
                 "valid":True,
                 "max":0,
                 "options":[
                    {
                       "_id":"",
                       "label":"option1",
                       "default":False,
                       "sequence":0,
                       "isValid":True
                    },
                    {
                       "_id":"",
                       "label":"option2",
                       "default":False,
                       "sequence":1,
                       "isValid":True
                    }
                 ],
                 "wasTyped":True
              }
           ],
           "tags":[
              "test ",
              "test2"
           ],
           "shortUrl":"",
           "actionTokensCost":0,
           "fastpass":""
      }
      """
     When I perform a POST  at the service "/surveys"
      And I save the body response as "survey_response"

  @Smoke
  Scenario: Answer a new survey
    Given I have the Authorization header
      And I add a body request
      """
      {
        "answers":[
            {
                "questionId":"5b5091c376917478e60fdeaa",
                "answers":[
                    0,
                    1
                ],
                "type":"multipleSelection"
            }
        ],
        "incognitoUser":False
      }
      """
    When I perform a POST  at the service "/surveys/{survey_response._id}/answers"
     And I save the body response as "answers_response"
    Then I expect status code "201"