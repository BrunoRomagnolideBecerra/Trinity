# Params class facade over a HTTPI request to allow management of parameters 
class ParamsHelper
  attr_reader :params
  attr_reader :raw_body
  attr_reader :body

  def initialize
    @params = {}
  end

  def add_daterange(days, start_name, end_name)
    @params[start_name] = Utilities.days_in_past days
    @params[end_name] = Utilities.today
  end

  def add(key, value)
    @params[key] = value
  end

  def add_raw_body(body)
    @raw_body = body
  end

  def add_body_params(body)
    @body = body
  end

end
