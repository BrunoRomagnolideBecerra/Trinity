Feature: Controls demo

  Scenario: Tables
    Given I navigate to "www.premierleague.com"
    When I scroll to the "footer" element
    And I hover the "Tickets" link inside the submenu
    And I click on the "Tables" link inside the submenu that takes me to the "Table" page
    Then I should see the "Sign In" link
    And I see the league_table header
    When I click on the "Home" link inside the submenu that takes me to the "Premier League Home" page
    Then I should see the "Sign In" link
    And I should see the Match List block

  Scenario: Survey
    Given I navigate to "https://surveyhero.com/c/all-question-types-example?ref="
    When I click on "next" and I navigate to the "surveys" page
    And I select "Yes option" radio button inside the "Do you like cats" section

  Scenario: Dropdown
    Given I navigate to "https://www.htmlquick.com/es/reference/tags/select.html"
    When I select the sport 'Hockey'

  Scenario: Premier League - Mobile Version
    Given I navigate to "www.premierleague.com"
    When I open on the hamburger menu
    And I click on the "Tables" link inside the submenu that takes me to the "Table" page
    Then I should see the "Sign In" link
    And I see the league_table header
    When I open on the hamburger menu
    And I click on the "Home" link inside the submenu that takes me to the "Premier League Home" page
    And I click on the "Matches" link
    Then I should see the "Sign In" link
    And I should see the Match List block