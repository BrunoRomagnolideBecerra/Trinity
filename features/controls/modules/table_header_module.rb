module TableHeaderModule

  def get_header(header_text, exact_match = false)
    headers = get_headers
    return headers.find { |header| header.text.include? header_text } unless exact_match
    headers.find { |header| header.text == header_text }
  end

  def get_headers
    @header.ths
  end

  def get_header_by_column_index(index)
    get_headers[index]
  end

  def header_index(header_text)
    index = 0
    get_headers.each do |header|
      return index if header.text.casecmp(header_text).zero?

      index += 1
    end
    -1
  end


end
