class PostgresClient

  # @return [PG::Connection]
  # @param [String] database
  # @param [String] user
  # @param [String] password
  # @param [Integer] port
  # @param [String] host
  def initialize(database, user = nil, password = nil, port = nil, host = nil)
    @client = PG.connect dbname: database, user: user, password: password, host: host, port: port
  end

  def execute(statement)
    @client.exec(statement)
  end

  def close
    @client.close
  end

end