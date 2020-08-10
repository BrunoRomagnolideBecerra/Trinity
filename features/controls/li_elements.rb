class LiElements < BaseElement

    def initialize(browser, value, locator)
      @collection = []
      browser.lis(locator.to_sym => value).each { |element| @collection.push(LiElement.new(nil, nil, nil, element)) }
    end

end