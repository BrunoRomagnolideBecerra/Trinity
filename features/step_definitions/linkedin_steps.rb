Then(/^I can see the name "([^"]*)" in the left side.$/) do |name|
  @context.page.left_panel.name.text.should eq name
end

Then(/I should see the icons at the top of the screen./) do |icons|
  icons = icons.raw
  icons.each do |icon|
    @context.page.head_panel.send(Formatters.string_to_snake_case(icon[0])).present?.should be true
  end
end

Then(/^I can see the position ""([^"]*)"" below the name.$/) do |value|
  @context.page.left_panel.position.present?.should be true
  @context.page.left_panel.position.value.should eq value
end

When(/^I click on the name link in the left panel$/) do
  @context = @context.page.left_panel.name.click_and_navigate_to 'profile_page'
end

Then(/^I should see the name "([^"]*)" in the name panel$/) do |name|
  expect(@context.name_panel.name.text).to eq name
end