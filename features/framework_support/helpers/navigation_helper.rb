require_relative '../page_factory'

class NavigationHelper
  def initialize(browser)
    @factory = PageFactory.new(browser)
  end

  def navigate_to(destination)
    @factory.create_page(destination)
  end
end
