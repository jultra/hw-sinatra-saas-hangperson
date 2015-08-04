Feature: Testing HANGPERSON homework
  In order to check that the supplied homework can be graded by AutoGrader
  As a AutoGrader maintainer
  I would like these homeworks to be automatically tested on submit

  Background: The homework is in place
    Given I have the public skeleton "saasbook/hw-sinatra-saas-hangperson" in "."
    And it is on the "master" branch
    And I have the reference application in "hw-sinatra-saas-hangperson"
    And I have the homework in "."

  Scenario Outline: Runs LOCAL SKELETON
    Given I kill any process using port "9292"
    And I have a sinatra app in "hw-sinatra-saas-hangperson"
    And I install the app
    And I run a sinatra server
    When I run AutoGrader for <test_subject> and <spec>
    Then I should see that the results are <expected_result>
    And I should see the execution results with <test_title>
    
    #When I run AutoGrader with "Heroku grader" strategy for <test_subject> and <spec>
    #Then I should see that the results are <expected_result>
    #And I should see the execution results with <test_title>
    #And I kill any process using port "9292"

 Examples:
    | test_title              | test_subject                | spec               | expected_result   |
    | Specs vs local skeleton | solutions/lib/localhost_uri | autograder/app_spec.rb | Score 100: 100 |

