require 'roo'
require 'roo-xls'

# SheetsHelper class contains functions to manage xlsx, xls and odt spreadsheets
class SheetsHelper

  # Opens the spreadsheet
  # @param [String] filename: Spreadsheet's filename
  def initialize(filename)
    @sheet = Roo::Spreadsheet.open(filename)
  end

  def info
    @sheet.info
  end

  def sheets
    @sheet.sheets
  end

  def sheet(name)
    @sheet.sheet(name)
  end

  def default_sheet(name)
    @sheet.default_sheet = name
  end

  def row(row, sheet = nil)
    return self.sheet(sheet).row(row) unless sheet.nil?

    @sheet.sheet(@sheet.default_sheet).row row
  end

  def column(column, sheet = nil)
    return self.sheet(sheet).column(column) unless sheet.nil?

    @sheet.sheet(@sheet.default_sheet).column column
  end

  def cell(row, col, sheet = nil)
    return self.sheet(sheet).cell(row, col) unless sheet.nil?

    @sheet.sheet(@sheet.default_sheet).cell(row, col)
  end

end