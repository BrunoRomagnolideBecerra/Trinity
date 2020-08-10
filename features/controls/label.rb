 class Label < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.label(locator.to_sym => value)
  end

  def click
    @control.wait_until(timeout: 30, &:present?)
    @control.click
  end

end