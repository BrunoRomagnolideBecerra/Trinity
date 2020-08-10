require_relative '../modules/table_header_module'
require_relative '../modules/table_module'
require_relative '../base_element'

class Table < BaseElement
  include TableModule
  include TableHeaderModule

  def initialize(browser, value, locator, override = nil)
    @control = override || browser.table(locator.to_sym => value)
    @header = @control.thead
  end

end
