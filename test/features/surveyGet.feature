#noinspection CucumberUndefinedStep
Feature: Get Survey

  Background:
    Given a survey
    And I add the header
    And I add the body :
      """
      {
         "_id":"",
         "actionTokens":{
            "maximumTokens":100,
            "usedTokens":0
         },
         "birthDate":"1994-10-10",
         "city":"cochabamba",
         "country":"Bolivia",
         "gender":"male",
         "name":"Robert",
         "password":"P@ssw0rd",
         "primaryEmail":"kiolop@mailbox87789.de",
         "role":"admin",
         "secondaryEmails":[

         ],
         "validated":True
      }
      """
    When I want to do a POST on a "/admin/users"
    And I save the project "Ariel"
#    Then I can verify the status code 201


#  Scenario:
#    Given a survey
#    And I add the body :
#      """
#      {
#      }
#      """
#    When I want to do a GET on a "/admin/users/{{USER_ID}}"
#    Then I can verify the status code 200

  Scenario:
    Given a survey
    And I add the body :
      """
      {

      }
      """
    When I want to do a DELETE on a "/admin/users/{{USER_ID}}"
    Then I can verify the status code 200
