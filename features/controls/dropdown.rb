class DropDown < BaseElement
  extend Forwardable

  def_delegators :@control, :clear, :select, :select_all

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.select_list(locator.to_sym => value)
  end

  def options
    @control.options.map(&:text)
  end

  def selected_options
    @control.selected_options.map(&:text)
  end

  def select_by_index(index)
    opts = options
    @control.select opts[index]
  end

  def options_included?(options)
    all_values = self.options
    options.each do |option|
      return false unless all_values.include? option
    end
    true
  end

end