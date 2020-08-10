require 'csv'

class CSVHelper

  def self.read_csv(file_name, col_sep: nil, row_sep: nil, headers: false, converters: nil )
    opts = {}
    opts[:headers] = headers
    opts[:col_sep] = col_sep unless col_sep.nil?
    opts[:row_sep] = row_sep unless row_sep.nil?
    opts[:converters] = converters unless converters.nil?
    csv = File.read(file_name)
    CSV.parse(csv, opts)
  end

  def self.generate_csv(matrix)
    matrix.map { |c| c.join(",") }.join("\n")
  end

end
