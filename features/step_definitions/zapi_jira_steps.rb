When(/^I create a cycle$/) do
  @cycle = CycleBuilder.build do |builder|
    builder.name 'My_cycle'
    builder.project_id 10000
    builder.version_id -1
    builder.build 'Build 1'
    builder.environment 'QA'
  end

  @zc = ZapiClient.new
  response = @zc.create_cycle @cycle
  expect(response.ok?).to be true
  resp = JSON.parse(response.body)
  puts resp

  @cycle.version_id = resp['versionId']
  @cycle.cycle_id = resp['id']
  @cycle.project_id = resp['projectId']
end

And(/^I get the cycle$/) do
  response = @zc.cycle @cycle
  expect(response.ok?).to be true
  puts response.body
end

And(/^I delete the cycle$/) do
  response = @zc.delete_cycle @cycle

  expect(response.ok?).to be true
  puts response.body
end

When(/^I get all cycles$/) do
  @cycle = CycleBuilder.build do |builder|
    builder.project_id 10000
    builder.version_id -1
  end
  @zc = ZapiClient.new
  response = @zc.cycles @cycle
  puts response.body
  expect(response.ok?).to be true
  @cycles = JSON.parse(response.body)
  pp @cycles
end

And(/^I update the cycle$/) do
  @cycle.name = 'Updated'
  response = @zc.update_cycle @cycle

  puts response.body
  expect(response.ok?).to be true
end

And(/^I add a test to a cycle$/) do
  json_cycle = @cycles.first
  @cycle = CycleBuilder.build do |builder|
    builder.project_id json_cycle['projectId']
    builder.version_id json_cycle['versionId']
    builder.issues ["TEST-1"]
    builder.id json_cycle['id']
  end

  response = @zc.add_test_to_cycle @cycle
  puts response.body
  expect(response.ok?).to be true
end

When(/^I create an execution for the first cycle$/) do
  @jc = JiraClient.new
  test_id = @jc.test_id 'TEST-1'
  json_cycle = @cycles.first
  execution_data = (ExecutionBuilder.build do |builder|
    builder.cycle_id json_cycle['id']
    builder.project_id 10000
    builder.version_id -1
    builder.issue_id "#{test_id}"
    builder.status ExecutionStatus::PASS
  end)

  response = @zc.create_and_update_execution_result execution_data
  puts response.body
  expect(response.ok?).to be true
end

When(/^I test all the jira's methods$/) do
  @jc = JiraClient.new
  pp @jc.project_info 'TEST'
  pp @jc.versions_id 'TEST'
  pp @jc.test_id 'TEST-1'
end