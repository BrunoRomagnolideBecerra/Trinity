class SQLDbHandler < DBHandler

  def initialize(client)
    super(client)
  end

  def connection?
    @logger.info(@no_connection) unless defined? @db_client

    defined? @db_client
  end

  def build_query(sql_script, *args)
    path = File.join(FileHelper.get_script_execution_path, SettingsHelper.trinity_settings('sql_scripts_path'))
    script = File.read(File.join(path, sql_script))
    arg_number = 1
    args.each do |arg|
      current_arg = '#args' + arg_number.to_s
      script.sub! current_arg, arg.to_s
      arg_number += 1
    end
    script
  end

  def execute_script(file, *args)
    script = build_query(file, *args)
    @logger.info("Executing script: #{script}")
    response = @db_client.execute(script)
    response.each.to_a
  end

  def close
    @db_client.close
  end

end