class MySQLClient

  # @return [Mysql2::Client]
  # @param [String] database
  # @param [String] username
  # @param [String] password
  # @param [Integer] port
  # @param [String] host
  def initialize(database, username = nil, password = nil, port = nil, host = nil)
    @client = Mysql2::Client.new(database: database, username: username, password: password, host: host, port: port)
  end

  def execute(statement)
    result = @client.query(statement)
    return [] if result.nil?

    result
  end

  def close
    @client.close
  end

end