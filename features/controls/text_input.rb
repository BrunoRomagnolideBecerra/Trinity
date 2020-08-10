class TextInput < Input

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.text_field(locator.to_sym => value)
  end

  def set_value(value)
    @control.set value
  end

  def value
    @control.value
  end

  def clear
    @control.clear
  end

  def input_value
    @input.value
  end

  def send_keys(value)
    @control.send_keys value
  end

end
