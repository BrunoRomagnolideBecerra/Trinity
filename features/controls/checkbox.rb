class Checkbox < BaseElement

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.checkbox(locator.to_sym => value)
  end

  def set(bool= true)
    @control.set(bool)
  end

  def selected?
    @control.set?
  end

end