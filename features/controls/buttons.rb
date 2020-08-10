require_relative 'base_collection'
class Buttons < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.buttons(locator.to_sym => value).each { |element| @collection.push(Button.new(nil, nil, nil, element)) }
  end

end