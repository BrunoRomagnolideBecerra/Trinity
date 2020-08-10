require_relative 'helpers/settings_helper'

# Page Factory is responsible for creating pages for a given name.
class PageFactory
  def initialize(browser)
    @driver = browser
    @configurations = SettingsHelper.page_configurations
  end

  def create_page(page_name)
    page_id = page_name.downcase.gsub(/[ \/]/, '_')
    get_page page_id
  end

  def get_page(page_id)
    if page_id == SettingsHelper.default_page
      configuration_page(SettingsHelper.default_page)
    else
      configuration_page(page_id)
    end
  end

  def configuration_page(page_id)
    ConfigurationPage.new(@driver, page_id)
  end

end