class Input < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.input(locator.to_sym => value)
  end

  def click
    @control.click
  end

  def click_and_navigate_to(page)
    click
    NAVHELPER.navigate_to(page)
  end

end
