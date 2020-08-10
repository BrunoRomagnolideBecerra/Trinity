# Headers class facade over a HTTPI request to allow management of headers
class HeadersHelper
  attr_reader :headers

  def initialize
    @headers = {}
  end

  def add(key, value)
    @headers[key] = value
  end
end
