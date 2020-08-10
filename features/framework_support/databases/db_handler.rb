# DB Handler Class is responsible for handling communications with the database
class DBHandler
  def initialize(client)
    @logger = Logger.new('database.log')
    @no_connection ||= 'No database connection available, please mark your\
 scenario with the @database tag.'
    @db_client = client
  end

  def client
    @db_client
  end

end
