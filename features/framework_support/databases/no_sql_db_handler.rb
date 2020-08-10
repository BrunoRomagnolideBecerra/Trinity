class NoSQLDbHandler < DBHandler

  @database = nil

  def initialize(client)
    super(client)
    @database = @db_client.database
  end

  def use_database(database)
    @db_client = @db_client.use(database.to_sym)
  end

  def database
    @db_client.database
  end

  def collection(collection)
    @db_client[collection.to_sym]
  end

  def build_object(json_template, *args)
    path = File.join(FileHelper.get_script_execution_path, SettingsHelper.trinity_settings('json_templates_path'))
    script = File.read(File.join(path, json_template))
    arg_number = 1
    args.each do |arg|
      current_arg = '#args' + arg_number.to_s
      script.sub! current_arg, arg.to_s
      arg_number += 1
    end
    JSON.parse(script)
  end

  def close
    @db
  end

end