Feature: Yahoo demo

  Scenario: Search term in Yahoo
    Given I move the browser window to the right
    And I am in the Yahoo home page
    When I enter the word "automation framework" in search box
    And I click the search button that navigates me to the "Yahoo results page"
    Then I should see the results
    And the first result title should be "A Guide to Automation Frameworks |Smartsheet"