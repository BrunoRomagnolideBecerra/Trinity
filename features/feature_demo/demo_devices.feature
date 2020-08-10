@Mobile
Feature: Feature title

  Scenario: Interact with calculator in android
    Given the calculator app is displayed
    When I enter the number "155" using the keypad
    And I tap the + sign
    And I enter the number "45" using the keypad
    And I tap the = sign
    Then the result should be "200"

  Scenario: Translate phrase in Google translator
    Given the Google Translate app is open
    When I enter the word "Edificio" in the text box
    Then I should see the word "Building" translated
    When I tap the switch language icon
    And I click on the cross to clean the input
    And I enter the word "Car" in the text box
    Then I should see the word "Coche" translated
    When I click on the cross to clean the input
    And I enter the word "That's all folks!" in the text box
    Then I should see the word "¡Eso es todo amigos!" translated

  Scenario: Translate phrase in Microsoft translator
    Given the Microsoft Translate app is open
    When I tap on the keyboard icon
    And I enter the word "Edificio" in the Translate app text box
    Then I should see the word "Building" translated in the translate app
    When I click on the cross to clean the input in the translate app
    And I enter the word "Coche" in the Translate app text box
    Then I should see the word "Car" translated in the translate app
    When I click on the cross to clean the input in the translate app
    And I enter the word "¡Eso es todo amigos!" in the Translate app text box
    Then I should see the word "That's all friends!" translated in the translate app