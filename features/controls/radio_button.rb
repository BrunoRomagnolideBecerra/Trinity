class RadioButton < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.radio(locator.to_sym => value)
  end

  def set(value)
    @control.set value
  end

  def click
    @control.wait_until(timeout: self.timeout, &:present?)
    @control.click
  end

  def selected?
    @control.set?
  end

end