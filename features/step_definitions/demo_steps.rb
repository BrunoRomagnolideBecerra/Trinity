Given(/^Perform a search in google "([^"]*)".$/) do |query|
  @context = Page.new(@driver).default_page
  @context.navigate_to_page
  @context.searchbox.send_keys query
  @context.searchbox.send_keys :enter
  @context = NAVHELPER.navigate_to 'results_page'
end

Then(/^A results page should appear$/) do
  Utilities.time_box_retry(30, true, 1) do
    @context.results.length > 0
  end
end

When(/^I select all the employees$/) do
  @context = @db[:sql].execute_script('select_all_employees.sql')
end

When(/^I insert a random employee$/) do
  @db[:sql].execute_script('insert_employee.sql', rand(500000..600000), '1980-01-01', 'IAM', 'MEDIA', 'M', '1990-01-01')
end

When(/^I delete the last inserted employee$/) do
  @db[:sql].execute_script('delete_employee.sql', 'IAM')
end

When(/^I insert a person named "([^"]*)" into the database$/) do |name|
  people = @db[:mongo].collection('people')
  people.insert_one(@db[:mongo].build_object('one_person.json', name))
end

And(/^I insert a (\d+) persons named "([^"]*)" and "([^"]*)" into the database$/) do |_, name, name2|
  people = @db[:mongo].collection('people')
  people.insert_many(@db[:mongo].build_object('two_persons.json', name, name2))
end

And(/^I delete all the persons named "([^"]*)"$/) do |name|
  people = @db[:mongo].collection('people')
  people.delete_many(@db[:mongo].build_object('name_only.json', name))
end

When(/^I do a GET request$/) do
  request = ServiceHelper.new base_url: 'https://cat-fact.herokuapp.com/', path: SettingsHelper.service_end_point('get_cat_fact')
  response = request.get
  expect(response.ok?).to be true
  puts JSON.parse(response.body)
end

When(/^I do a POST request$/) do
  request = ServiceHelper.new base_url: 'https://reqbin.com/', path: SettingsHelper.service_end_point('post')
  request.headers.add 'Content-Type', 'application/json'
  request.body.add 'Id', 12345
  request.body.add 'Customer', "John Smith"
  request.body.add 'Quantity', 1
  request.body.add 'Price', 10.00
  response = request.post
  expect(response.ok?).to be true
  puts JSON.parse(response.body)

end

When(/^I do an authenticated GET request$/) do
  request = ServiceHelper.new base_url: 'https://inallmedia.atlassian.net/', path: SettingsHelper.service_end_point('my_self')
  request.auth 'basic', 'user@inallmedia.com', 'api_key'
  request.headers.add 'Accept', 'application/json'
  response = request.get
  puts JSON.parse(response.body)
  expect(response.ok?).to be true
end