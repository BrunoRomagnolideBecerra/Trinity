require_relative 'base_collection'
class Inputs < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.inputs(locator.to_sym => value).each { |element| @collection.push(Input.new(nil, nil, nil, element)) }
  end

end