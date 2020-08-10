# Response class facade over a HTTPI response to allow testing of a response
class ResponseHelper
  attr_reader :response
  attr_reader :body
  attr_reader :parsed_body

  SUCCESS_CODES = [200, 201, 202, 203, 204].freeze
  ERROR_CODES = [400, 401, 402, 403, 404, 405, 422, 500, 503].freeze

  def initialize(response)
    @response = response
    @body = @response.raw_body
    @parsed_body = parse_body_as_json
  end

  def ok?
    SUCCESS_CODES.include? @response.code
  end

  def failed?
    ERROR_CODES.include? @response.code
  end

  private

  def parse_body_as_json
    JSON.parse(body)
  rescue
    nil
  end
end
