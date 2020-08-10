Around('@database') do |_scenario, block|
  @db = SettingsHelper.initialize_databases 'database_connections'
  block.call
  @db.close_all_connections
  @db = nil
end

Before do |scenario|
  WorldOrder.scenario scenario
  if WorldOrder.scenario_helper.browser_needed?
    @driver ||= WorldOrder.init_driver
    self.class.const_set('NAVHELPER', NavigationHelper.new(@driver)) unless WorldOrder.scenario_helper.mobile?
  end
end

After do |scenario|
  if scenario.failed?
    guid = SecureRandom.uuid
    file_name = WorldOrder.file_name guid
    path = WorldOrder.capture_dir

    unless WorldOrder.scenario_helper.tag?('@Rest')
      capture_screenshot path, file_name
    end

  end
  if WorldOrder.scenario_helper.browser_needed?
    WorldOrder.close_driver unless @driver.nil?
  end
end

def capture_screenshot(path, file_name)
  screenshot = File.join(path, file_name + '.png')
  # use the save_stitch function if it's a sit specific test
  if @driver
    @driver.driver.save_screenshot(screenshot)
    embed Base64.encode64(File.open(screenshot, 'rb', &:read)), 'image/png;base64'
  end
end


at_exit do
  Reporting.run File.basename(Dir.pwd + "/report.json")
end
