class OCIClient

  # @param [String] statement
  def execute(statement)
    cursor = @client.exec(statement)
    results = []
    # exec returns the number of modified rows (insert, delete or update only)
    unless statement.downcase.include? 'select'
      # Commit only if it is insert, delete or update
      @client.commit
      return results
    end

    # statement is select
    while (row = cursor.fetch_hash)
      results.push(row)
    end
    cursor.close
    results
  end

  def initialize(*args)
    username, password, host, port, service_name = args
    conn_string = host + ':' + port + '/' + service_name
    @client = OCI8::new(username, password, conn_string)
  end

  def close
    @client.logoff
  end

end