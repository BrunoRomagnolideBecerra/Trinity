Given(/^I navigate to "([^"]*)"$/) do |url|
  Browser.go_to url
  @context = NAVHELPER.navigate_to 'Premier League Home'
end

Given(/^I am in the Duckduckgo home page$/) do
  Browser.go_to 'http://www.duckduckgo.com'
  @context = NAVHELPER.navigate_to 'duckduckgo'
end

Given(/^I am in the Yahoo home page$/) do
  Browser.go_to 'http://www.yahoo.com'
  @context = NAVHELPER.navigate_to 'yahoo'
end

When(/^I click on the "([^"]*)" link inside the submenu that takes me to the "([^"]*)" page$/) do |item_name, destination|
  link = @context.sub_nav.send(Formatters.string_to_snake_case(item_name))
  @context = link.click_and_navigate_to destination
end

Then(/^I see the league_table header$/) do
  @context.league_table.wait_until(&:present?)
  expect(@context.league_table.present?).to be true
end

When(/^I click on "([^"]*)" and I navigate to the "([^"]*)" page$/) do |element, destination|
  @context = @context.send(Formatters.string_to_snake_case(element)).click_and_navigate_to destination
end

When(/^I select "([^"]*)" radio button inside the "([^"]*)" section$/) do |option, container|
  radio = @context.send(Formatters.string_to_snake_case(container)).send(Formatters.string_to_snake_case(option))
  radio.set
end

When(/^I select the sport 'Hockey'$/) do
  @context.select_1.options_included? ['Hockey', 'pepe']
end

Then(/^I should see the "([^"]*)" link$/) do |link|
  link = @context.send(Formatters.string_to_snake_case(link))
  link.wait_until(timeout: 60, &:present?)
  expect(link.present?).to be true
end

Then(/^I should see the Match List block$/) do
  expect(@context.send(Formatters.string_to_snake_case('match_list')).present?).to be true
end

When(/^I scroll to the "([^"]*)" element$/) do |element|
  @context.send(Formatters.string_to_snake_case(element)).scroll_to
end

When(/^I hover the "([^"]*)" link inside the submenu$/) do |element|
  @context.sub_nav.send(Formatters.string_to_snake_case(element)).hover
end

When(/^I open on the hamburger menu$/) do
  @context.send('hamburger_menu').wait_until(timeout: 60, &:present?)
  @context.send('hamburger_menu').click
end

And(/^I click on the "([^"]*)" link$/) do |element|
  @context.send(Formatters.string_to_snake_case(element)).click
end

When(/^I enter the word "([^"]*)" in search box$/) do |value|
  @context.send(Formatters.string_to_snake_case('search_input')).send_keys value
end

When(/^I click the search button that navigates me to the "([^"]*)"$/) do |destination|
  @context = @context.send(Formatters.string_to_snake_case('search_button')).click_and_navigate_to destination
end

When(/^the first result title should be "([^"]*)"$/) do |result|
  expect(@context.send(Formatters.string_to_snake_case('result_titles')).first.text.include? result).to be true
end

Then(/^I should see the results$/) do
  @context.send(Formatters.string_to_snake_case('results')).wait_until(&:present?)
  expect(@context.send(Formatters.string_to_snake_case('results')).present?).to be true
end

When(/^I move the browser window to the (left|right)$/) do |position|
  width = @driver.window.size.width
  height = @driver.window.size.height
  @driver.window.resize_to width / 2, height
  if position == 'left'
    @driver.window.move_to 0,0
  else
    @driver.window.move_to width / 2, height / 2
  end
end