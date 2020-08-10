require_relative 'base_collection'
class Labels < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.labels(locator.to_sym => value).each { |element| @collection.push(Label.new(nil, nil, nil, element)) }
  end

end