require_relative 'base_collection'

class TextAreas < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.text_areas(locator.to_sym => value).each { |element| @collection.push(TextArea.new(nil, nil, nil, element)) }
  end

end