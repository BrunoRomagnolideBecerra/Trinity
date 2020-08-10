require_relative 'base_collection'
class Divs < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.divs(locator.to_sym => value).each { |element| @collection.push(Div.new(nil, nil, nil, element)) }
  end

end