# World Order Module used to manage helpers
module WorldOrder
  @scenario_helper = nil
  @driver = nil
  @logger = nil

  def self.init_driver
    if SettingsHelper.device == 'desktop'
      if SettingsHelper.browser == 'edge'
        @driver = Browser.initialize_edge
      elsif SettingsHelper.browser == 'chrome'
        @driver = Browser.initialize_chrome
      elsif SettingsHelper.browser == 'safari'
        @driver = Browser.initialize_safari
      elsif SettingsHelper.browser == 'firefox'
        @driver = Browser.initialize_firefox
      else
        raise Exception, "Not a valid browser. Supported values are: 'chrome', 'firefox', 'safari', 'edge'"
      end
    elsif (SettingsHelper.device == 'android') || (SettingsHelper.device == 'ios')
      @driver = Browser.initialize_device
    else
      raise Exception, "Not a valid option device. Supported values are: 'desktop', 'android', 'ios'. Check your environment file"
    end

  end

  def self.driver
    @driver
  end

  def self.close_driver
    if @driver.instance_of? Appium::Driver
      @driver.driver_quit
    else
      @driver.close
    end
  end

  def self.scenario(scenario)
    @scenario_helper = ScenarioHelper.new scenario
  end

  def self.scenario_helper
    @scenario_helper
  end

  def self.clean_screen_shot_directory
    ss_path = "#{Dir.pwd}/screenshots/."
    FileUtils.rm_rf(ss_path, secure: true) if File.directory?('screenshots')
  end

  def self.capture_dir
    Dir.mkdir('screenshots') unless File.directory?('screenshots')
    File.join(Dir.pwd, '/screenshots/')
  end

  def self.file_name(guid)
    "#{ENV['ENV'].upcase}_FAILED_#{DateTime.now.strftime('%m-%d-%Y_%I.%M.%S')}_#{guid}"
  end

  def self.log
    @log ||= Logger.new STDOUT
  end

end
