class Checkboxes < BaseElement

  def initialize(browser, value, locator)
    @collection = []
    browser.checkboxes(locator.to_sym => value).each { |element| @collection.push(Checkbox.new(nil, nil, nil, element)) }
  end

end