class TableRow < BaseElement
  include TableHeaderModule

  def initialize(row, header)
    @row = row
    @header = header
  end

  def column_value(header)
    index = header_index(header)
    @row[index]
  end

  def column_text_value(header)
    column_value(header).text
  end

  def column_eql?(column, text)
    column_value(column).text.eql? text.to_s
  end

  def column_include?(column, text)
    column_value(column).text.include? text.to_s
  end

  def present?
    @row.present?
  end

end
