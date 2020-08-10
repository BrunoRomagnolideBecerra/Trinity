module TableModule

  def column_contains?(header, value)
    index = header_index(header)
    rows.each do |row|
      return false if row[index].text.include? value
    end

    true
  end

  def column_contains_at_least_one?(header, value)
    index = header_index(header)
    rows.each do |row|
      return true if row[index].text.include? value
    end

    false
  end

  def get_row_contains(header, value)
    grid_rows.each do |row|
      return row if row.column_include?(header, value)
    end

    nil
  end

  def data?
    grid_rows.count > 0
  end

  def rows
    @control.tbody.trs
  end

  def grid_rows
    row_array = []
    rows.each do |row|
      row_array.push TableRow.new(row, @header) if row.present?
    end
    row_array
  end

  def row(header, value)
    index = header_index(header)
    rows.each do |row|
      return TableRow.new(row, @header) if cell_text_contains?(row, index, value)
    end

    nil
  end

  def row_exact_text(header, value)
    index = header_index(header)
    rows.each do |row|
      return TableRow.new(row, @header) if cell_text_exact?(row, index, value)
    end

    nil
  end

  def first_row_data
    TableRow.new(rows[0], @header)
  end

  def column_contains_either(header, *values)
    index = header_index(header)
    rows.each do |row|
      return false unless cell_text_contains_either?(row, index, values)
    end

    true
  end

  private

  def cell_text(row, index)
    row[index].text
  end

  def cell_text?(row, index, text)
    cell_text(row, index).casecmp(text)
  end

  def cell_text_exact?(row, index, text)
    cell_text(row, index).eql? text
  end

  def cell_text_contains?(row, index, text)
    cell_text(row, index).include? text
  end

  def cell_text_include?(row, index, text)
    cell_text(row, index).downcase.include? text.downcase
  end

  def cell_text_contains_either?(row, index, *values)
    values.include? cell_text(row, index)
  end

end
