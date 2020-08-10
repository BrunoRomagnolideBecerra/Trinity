require 'date'
# Formatters class contains functions for formatting data
class Formatters
  def self.remove_spaces(string)
    string.gsub(/[ ]/, '')
  end

  def self.string_to_snake_case(string)
    origin = string.clone
    origin.downcase!
    origin.tr!(' ', '_')
    origin.tr!('/', '_')
    origin.tr!('-', '_')
    origin.rstrip!

    origin
  end

  def self.underscores_to_spaces(string)
    string.gsub(/_/, ' ')
  end

  def self.spaces_to_underscores(string)
    string.gsub(' ', '_')
  end

  def self.format_date(month, day, year)
    month + '/' + day + '/' + year
  end

  def self.to_lower_keycase(string)
    string.gsub(/[ ]/, '_').downcase!
  end

  def self.to_internation_date_format(date)
    date_format = '%Y-%m-%dT%H:%M:%S'

    dstart = DateTime.strptime(date, "%m/%d/%YT%H:%M:%S").to_datetime
    dstart = DateTime.new(dstart.year, dstart.month, dstart.day, dstart.hour, dstart.minute, dstart.second)

    dstart.strftime(date_format)
  end

  # convert a camel case string to an underscored string
  def self.underscore(string)
    string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
  end

  def self.snake_case_to_camel_case(string)
    str = string.split('_').collect(&:capitalize).join
    str[0] = str[0].downcase
    str
  end

  def self.camel_case_to_snake_case(string)
    string.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
  end

end
