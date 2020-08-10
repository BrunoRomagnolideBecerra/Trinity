require_relative 'base_collection'
class BaseElements < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.elements(locator.to_sym => value).each { |element| @collection.push(BaseElement.new(nil, nil, nil, element)) }
  end

end