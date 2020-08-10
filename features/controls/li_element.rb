class LiElement < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.li(locator.to_sym => value)
  end

  def click
    @control.wait_until(timeout: 30, &:present?)
    @control.click
  end

end