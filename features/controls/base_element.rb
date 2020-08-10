class BaseElement
  extend Forwardable
  def_delegators :@control, :present?, :enabled?, :disabled?, :wait_until, :wait_while, :text, :attribute_value, :attribute_values,
                 :focused?, :click!, :double_click, :double_click!, :hover, :size, :tag_name, :click

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.element(locator.to_sym => value)
    timeout
  end

  def timeout
    @timeout = SettingsHelper.implicit_wait_timeout
  end

  def css_property(property)
    @control.style(property)
  end

  def scroll_to(param = :top)
    # accepted values: top, end, start, bottom
    @control.scroll.to(param)
  end

end