Feature: DB demo feature.

  @NoBrowserNeeded @database
  Scenario: Mysql example
    When I select all the employees
    And I insert a random employee
    And I delete the last inserted employee

  @NoBrowserNeeded @database
  Scenario: PG example
    When I select all the employees
    And I insert a random employee
    And I delete the last inserted employee

  @NoBrowserNeeded @database
  Scenario: MongoDB example
    When I insert a person named "Carlos" into the database
    And I insert a 2 persons named "Juan" and "Pedro" into the database
    And I delete all the persons named "Carlos"

  @NoBrowserNeeded
  Scenario: API calls
    When I do an authenticated GET request
    And I do a GET request
    And I do a POST request