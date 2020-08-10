class Link < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.a(locator.to_sym => value)
  end

  def click
    @control.wait_until(timeout: self.timeout, &:present?)
    @control.click
  end

  def click_and_navigate_to(page)
    click
    NAVHELPER.navigate_to(page)
  end

  def link
    @control.href
  end

end