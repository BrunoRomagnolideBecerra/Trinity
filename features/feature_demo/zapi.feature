@NoBrowserNeeded @Rest
Feature: Zapi and Jira clients test

  Scenario: Create get and delete cycle
    When I create a cycle
    And I get the cycle
    And I delete the cycle

  Scenario: get_cycles
    When I get all cycles

  Scenario: update cycle
    When I create a cycle
    And I update the cycle

  Scenario: Add test to cycle
    When I get all cycles
    And I add a test to a cycle

  Scenario: Create execution
    When I get all cycles
    And I create an execution for the first cycle

  Scenario: Get project id
    When I test all the jira's methods
