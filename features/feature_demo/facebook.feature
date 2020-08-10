@Test
Feature: Dummy testing Facebook

  Scenario: Login into Facebook and check navigation menu and other elements.
    When I log into "Facebook" as "facebook_user".
    Then I can see the name "John Frame" in the left side.
    And I should see the icons at the top of the screen.
      | Home             |
      | Find Friends     |
      | Create           |
      | Friend Requests  |
      | Messages         |
      | Notifications    |