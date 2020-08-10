require_relative '../base_collection'
class Tables < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.tables(locator.to_sym => value).each { |element| @collection.push(Table.new(nil, nil, nil, element)) }
  end

end