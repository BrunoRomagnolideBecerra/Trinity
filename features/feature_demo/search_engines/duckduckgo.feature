Feature: DuckDuckGo demo

  Scenario: Search term in duckduckgo
    Given I move the browser window to the left
    And I am in the Duckduckgo home page
    When I enter the word "automation framework" in search box
    And I click the search button that navigates me to the "Duckduckgo results page"
    Then I should see the results
    And the first result title should be "Ranorex Automation Framework - Desktop, Web & Mobile"