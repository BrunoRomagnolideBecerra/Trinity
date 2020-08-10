@Test
Feature: Dummy testing Linkedin

  Scenario Outline: Login into Linkedin and check navigation menu and other elements.
    When I log into "Linkedin" as "linkedin_user".
    Then I can see the name "<user name>" in the left side.
    And I should see the icons at the top of the screen.
      | Home          |
      | My Network    |
      | Jobs          |
      | Messaging     |
      | Notifications |
      | Me            |
      | Work          |
    When I click on the name link in the left panel
    Then I should see the name "<user name>" in the name panel
    Examples:
      | user name           |
      | your user name here |