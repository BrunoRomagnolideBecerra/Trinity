require 'selenium-webdriver'
require 'watir'
require 'appium_lib'

class Browser

  def self.initialize_safari
    webdriver_path = SettingsHelper.trinity_settings('webdrivers')['safari']
    Selenium::WebDriver::Safari::Service.driver_path = webdriver_path unless webdriver_path.nil? || webdriver_path.empty?
    Watir::Browser.new :safari
  end

  def self.initialize_edge
    webdriver_path = SettingsHelper.trinity_settings('webdrivers')['edge']
    Selenium::WebDriver::Edge::Service.driver_path = webdriver_path unless webdriver_path.nil? || webdriver_path.empty?
    Watir::Browser.new :edge
  end

  def self.initialize_firefox
    webdriver_path = SettingsHelper.trinity_settings('webdrivers')['firefox']
    Selenium::WebDriver::Firefox::Service.driver_path = webdriver_path unless webdriver_path.nil? || webdriver_path.empty?
    Watir::Browser.new :firefox
  end

  def self.initialize_chrome
    webdriver_path = SettingsHelper.trinity_settings('webdrivers')['chrome']
    Selenium::WebDriver::Chrome::Service.driver_path = webdriver_path unless webdriver_path.nil? || webdriver_path.empty?
    switches = SettingsHelper.chrome_switches || {}
    options = SettingsHelper.chrome_options || {}
    Watir::Browser.new :chrome, options: {args: switches, options: options}
  end

  def self.initialize_device
    profile = SettingsHelper.device_profile
    caps = SettingsHelper.device_caps(profile)
    if !caps['appPackage'].nil?
      appium_driver = Appium::Driver.new({
                                             'caps' => caps,
                                             'appium_lib' => {
                                                 :server_url => SettingsHelper.device_server
                                             }}, true)
      appium_driver.start_driver
      appium_driver
    else
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 120 # seconds
      driver = Selenium::WebDriver.for(
          :remote,
          desired_capabilities: SettingsHelper.device_caps(profile),
          url: SettingsHelper.device_server,
          http_client: client
      )

      Watir::Browser.new driver
    end
  end

  def self.reload_page(driver)
    url = driver.url
    driver = WorldOrder.driver
    driver.goto url
    driver
  end

  def self.go_to(url)
    WorldOrder.driver.goto url
  end

end
