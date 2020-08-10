Given(/^the calculator app is displayed$/) do
  button = @driver.find_element(:id, 'com.google.android.calculator:id/digit_1')
  expect(button.displayed?).to be true
end

When(/^I enter the number "([^"]*)" using the keypad$/) do |number|
  number.chars.each { |digit|
    @driver.find_element(:id, "com.google.android.calculator:id/digit_#{digit}").click
    sleep(0.5)
  }
end

When(/^I tap the \+ sign$/) do
  @driver.find_element(:id, "com.google.android.calculator:id/op_add").click
end

When(/^I tap the \= sign$/) do
  @driver.find_element(:id, "com.google.android.calculator:id/eq").click
end

Then(/^the result should be "([^"]*)"$/) do |result|
  res = @driver.find_element(:id, "com.google.android.calculator:id/result_final").text
  expect(res).to eq result
end

Given(/^the Google Translate app is open$/) do
  configure_app = @driver.find_element(:id, 'com.google.android.apps.translate:id/activity_onboarding_toplevel')
  if configure_app.displayed?
    @driver.find_element(:id, 'com.google.android.apps.translate:id/onboarding_checkbox').click
    @driver.find_element(:id, 'com.google.android.apps.translate:id/button_done').click
  end
  toolbar = @driver.find_element(:id, 'com.google.android.apps.translate:id/toolbar')
  expect(toolbar.displayed?).to be true
  @driver.find_element(:id, 'com.google.android.apps.translate:id/lyt_home').click
end

When(/^I enter the word "([^"]*)" in the text box$/) do |word|
  text_input = @driver.find_element(:id, 'com.google.android.apps.translate:id/touch_to_type_text')
  text_input.click
  sleep 1
  text_input = @driver.find_element(:id, 'com.google.android.apps.translate:id/edit_input')
  text_input.send_keys word
  @driver.find_element(:id, 'com.google.android.apps.translate:id/result_layout').click
end

When(/^I enter the word "([^"]*)" in the Translate app text box$/) do |word|
  sleep 1
  text_input = @driver.find_element(:id, 'com.microsoft.translator:id/bbaret_translate_from')
  text_input.click
  sleep 1
  text_input.send_keys word
end

Then(/^I should see the word "([^"]*)" translated$/) do |result|
  res = @driver.find_element(:xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/androidx.drawerlayout.widget.DrawerLayout/android.widget.FrameLayout/android.widget.ScrollView/android.widget.LinearLayout/android.widget.LinearLayout[1]/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.TextView").text
  expect(res).to eq result
end

Then(/^I should see the word "([^"]*)" translated in the translate app$/) do |result|
  sleep 2
  res = @driver.find_element(:id, "com.microsoft.translator:id/artv_translated_text").text
  expect(res).to eq result
end

When(/^I tap the switch language icon$/) do
  @driver.find_element(:id, 'com.google.android.apps.translate:id/btn_lang_picker_swap').click
end

When(/^I click on the cross to clean the input$/) do
  @driver.find_element(:id, 'com.google.android.apps.translate:id/active_dictation_mode').click
end

When(/^I click on the cross to clean the input in the translate app$/) do
  @driver.find_element(:id, 'com.microsoft.translator:id/ib_clear').click
end

Given(/^the Microsoft Translate app is open$/) do
  @driver.find_element(:id, 'com.microsoft.translator:id/btn_privacy_continue').click
  welcome_msg = @driver.find_element(:id, 'com.microsoft.translator:id/tv_welcome')
  expect(welcome_msg.displayed?).to be true
end

When(/^I tap on the keyboard icon$/) do
  @driver.find_element(:id, 'com.microsoft.translator:id/iv_text_translation').click
end