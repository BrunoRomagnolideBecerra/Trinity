require_relative 'base_collection'
class Links < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.as(locator.to_sym => value).each { |element| @collection.push(Link.new(nil, nil, nil, element)) }
  end

end