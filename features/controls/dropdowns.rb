require_relative 'base_collection'
class Dropdowns < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.select_lists(locator.to_sym => value).each { |element| @collection.push(DropDown.new(nil, nil, nil, element)) }
  end

end