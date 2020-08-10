Given(/^I log into "([^"]*)" as "([^"]*)".$/) do |env, user|
  USERS = SettingsHelper.user_configuration(env.downcase, user)
  @context = LoginPage.new(@driver)
  username = USERS['name']
  password = USERS['password']

  @context = @context.default_page
  @context.page.username.set_value(username)
  @context.page.password.set_value(password)
  @context.page.login_button.click
end