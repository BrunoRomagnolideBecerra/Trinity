When(/^I get all the sheets$/) do
  @sheets = @sheet.sheets
  puts @sheets
end

And(/^I print all the headers$/) do
  @sheets.each { |x|
    puts @sheet.sheet(x).row(1) }
end

Given(/^I load the "([^"]*)" xlsx file$/) do |file|
  @sheet = SheetsHelper.new file
end

When(/^I read the csv file "([^"]*)"$/) do |file|
  csv = CSVHelper.read_csv file
  pp csv
end

When(/^I read the xml file "([^"]*)"$/) do |file|
  xml = XMLHelper.parse_xml_file file
  pp xml
end