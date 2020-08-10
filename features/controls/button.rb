class Button < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.button(locator.to_sym => value)
  end

  def click
    @control.wait_until(timeout: self.timeout, &:present?)
    @control.click
  end

  def click_and_navigate_to(destination)
    click
    NAVHELPER.navigate_to(destination)
  end
end