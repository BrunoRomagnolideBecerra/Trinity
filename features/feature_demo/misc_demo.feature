Feature: Miscellaneous tests

  @NoBrowserNeeded
  Scenario: Test sheet helper
    Given I load the "Your XLSX File" xlsx file
    When I get all the sheets
    And I print all the headers

  @NoBrowserNeeded
  Scenario: Read CSV and XMl
    When I read the csv file "Your CSV File"
    And I read the xml file "Your XML File"