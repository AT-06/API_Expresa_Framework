#noinspection CucumberUndefinedStep
Feature: Get Survey

#  Scenario:
#    Given a survey
#    And I add the body :
#      """
#      {
#       "surveyCosts": {
#           "survey": 25,
#           "question": 19,
#           "publish": 9
#           }
#      }
#      """
#    When I want to do a PUT on a "/constraints/survey"
##    And I add the header:
##    """
##        {
##        "Authorization": "token"
##        }
##    """
#
##      And I send the request
#    Then I can verify the status code 200

  Background: :
    Given a survey
    And I add the header
    And I add the body :
      """
      {
        "name": "probandol",
        "new_account_name": "Ariel411"
      }
      """
    When I want to do a POST on a "/projects"
    And I save the project "probandolo"


  Scenario:
    Given a survey
    And I add the body :
      """
      {

      }
      """
    When I want to do a GET on a "/projects/{{project_id}}"
    Then I can verify the status code 200

  Scenario:
    Given a survey
    And I add the body :
      """
      {

      }
      """
    When I want to do a DELETE on a "/projects/{project_id}"
    Then I can verify the status code 204

