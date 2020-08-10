require_relative 'base_collection'
class TextInputs < BaseCollection

  def initialize(browser, value, locator)
    @collection = []
    browser.text_fields(locator.to_sym => value).each { |element| @collection.push(TextInput.new(nil, nil, nil, element)) }
  end

end