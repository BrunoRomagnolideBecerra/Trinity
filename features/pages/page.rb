class Page

  def initialize(browser)
    @browser = browser
    @start_url = SettingsHelper.environment['base_url']
  end

  def navigate_to_page
    @browser.goto @start_url
  end

  def default_page
    factory = PageFactory.new @browser
    factory.create_page SettingsHelper.default_page
  end

  def page
    self
  end
end
