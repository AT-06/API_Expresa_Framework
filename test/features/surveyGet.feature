#noinspection CucumberUndefinedStep
Feature: Get Survey

  Scenario:
    Given a survey
    And I add the body :
      """
      {
       "surveyCosts": {
           "survey": 25,
           "question": 19,
           "publish": 9
           }
      }
      """
    When I want to do a PUT on a "/constraints/survey"
#    And I add the header:
#    """
#        {
#        "Authorization": "token"
#        }
#    """

#      And I send the request
    Then I can verify the status code 200

