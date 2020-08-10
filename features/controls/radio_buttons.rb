require_relative 'base_collection'
class RadioButtons < BaseElement

  def initialize(browser, value, locator)
    @collection = []
    browser.as(locator.to_sym => value).each { |element| @collection.push(RadioButton.new(nil, nil, nil, element)) }
  end

end