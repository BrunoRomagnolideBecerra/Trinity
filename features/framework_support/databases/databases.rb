class Databases

  def initialize
    @connections = {}
  end

  def []=(name, client)
    @connections[name.to_sym] = client
  end

  def [](connection)
    @connections[connection]
  end

  def close_all_connections
    @connections.keys.each { |key| @connections[key].client.close }
  end
end