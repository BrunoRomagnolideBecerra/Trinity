class Div < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.div(locator.to_sym => value)
  end

  def click
    @control.wait_until(timeout: 30, &:present?)
    @control.click
  end

  def click_and_navigate_to(page)
    click
    NAVHELPER.navigate_to(page)
  end
end