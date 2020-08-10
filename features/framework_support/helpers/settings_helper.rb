require 'os'

class SettingsHelper
  SETTINGS_FILE = 'trinity_settings.yml'.freeze
  raise IOError, 'The file "trinity_settings.yml" was not found in the root folder of your project ' unless File.exist? File.join(Dir.pwd, SETTINGS_FILE)
  raise ArgumentError, 'Support_folder_path is not defined in trinity_settings.yml ' if YAML.load_file(File.join(Dir.pwd, SETTINGS_FILE))['support_folder_path'].nil?

  SOLUTIONS_PATH = File.join(Dir.pwd, YAML.load_file(File.join(Dir.pwd, SETTINGS_FILE))['support_folder_path'])
  SUPPORT ||= File.join(SOLUTIONS_PATH, 'support')
  raise IOError, 'Support folder was not found. Please check support_folder_path value in trinity_settings.yml ' unless File.exist? SUPPORT

  OS.windows? ? CONFIGURATION ||= '/page_configurations'.freeze : CONFIGURATION ||= 'page_configurations'.freeze
  CONFIGURATION_EXTENSION ||= '.yml'.freeze

  def self.environment
    SettingsHelper.settings('environments', ENV['ENV'])
  end

  def self.desktop?
    SettingsHelper.environment['device'].casecmp('desktop').zero?
  end

  def self.mobile?
    device = SettingsHelper.environment['device']
    device.casecmp('ios').zero? || device.casecmp('android').zero?
  end

  def self.database_configurations(connection)
    SettingsHelper.settings('databases', connection)
  end

  def self.user_configurations
    SettingsHelper.settings('users', SettingsHelper.environment['users']) unless SettingsHelper.environment['users'].nil?
  end

  def self.user_configuration(user_file, user)
    SettingsHelper.settings('users', user_file)[user]
  end

  def self.browser
    SettingsHelper.environment['browser']
  end

  def self.device
    SettingsHelper.environment['device']
  end

  def self.device_profile
    SettingsHelper.environment['device_profile']
  end

  def self.current_device_profile
    SettingsHelper.device_caps(SettingsHelper.device_profile)
  end

  def self.device_server
    SettingsHelper.environment['appium_server']
  end

  def self.device_caps(node)
    settings('devices_profiles', 'devices')[node]
  end

  def self.device_type
    SettingsHelper.environment['device_type']
  end

  def self.chrome_switches
    filename = 'chrome_switches' + '.yml'
    file = File.join(SUPPORT, [filename])
    if File.exist? file
      YAML.load_file(file)['switches']
    else
      WorldOrder.log.warn "File #{filename} does not exist."
      nil
    end
  end

  def self.email_options
    file = File.join(SUPPORT, ['email', 'settings' + '.yml'])
    YAML.load_file(file)['email_settings']
  end

  def self.chrome_options
    filename = 'chrome_options' + '.yml'
    file = File.join(SUPPORT, [filename])
    if File.exist? file
      YAML.load_file(file)['options']
    else
      WorldOrder.log.warn "File #{filename} does not exist."
      nil
    end
  end

  def self.settings(directory, name)
    file = File.join(SUPPORT, directory, name + '.yml')
    YAML.load_file(file)
  end

  def self.trinity_settings(node)
    trinity_settings_file = File.join(Dir.pwd, SETTINGS_FILE)
    return unless File.exist? trinity_settings_file

    config = YAML.load_file(trinity_settings_file)
    config[node]
  end

  def self.implicit_wait_timeout
    self.trinity_settings('implicit_wait_timeout') || 30
  end


  def self.jira_settings
    settings('', 'jira_settings')
  end

  def self.zephyr_settings
    settings('', 'zephyr_settings')
  end

  def self.value_for_key(key, sub_key = 'nil')
    clean_key = Formatters.remove_spaces key
    value = SettingsHelper.environment[clean_key]
    value = value[Formatters.remove_spaces sub_key] unless sub_key.eql? 'nil'
    value
  end

  def self.service_end_point(folder = '/api', name)
    # By default it grabs the value of rest_end_point in support/api/restful.yml
    file = '/restful_api.yml'
    location = File.join(SUPPORT, folder, file)

    if File.exist? location
      config = YAML.load_file(location)
      return config['rest_end_point'][name]
    end

    ''
  end

  def self.page_configurations
    configurations = {}
    local_settings_path = File.join(SUPPORT, CONFIGURATION, SettingsHelper.configurations_dir)
    Dir.foreach(local_settings_path) do |file|
      next unless File.extname(file) == CONFIGURATION_EXTENSION

      name = File.basename(file, CONFIGURATION_EXTENSION)
      yaml = YAML.load_file(File.join(local_settings_path, file))
      configurations[name] = yaml
    end

    configurations
  end

  def self.configuration?
    !SettingsHelper.configurations_dir.nil?
  end

  def self.configurations_dir
    SettingsHelper.environment['page_configurations']
  end

  def self.page_configuration(name)
    SettingsHelper.page_configurations[name]
  end

  def self.default_page
    SettingsHelper.environment['default_page']
  end


  def self.initialize_databases(connection)
    db = Databases.new
    config = SettingsHelper.environment[connection]
    dbs = {}
    raise Exception, "Check the environment file and make sure 'database_connections' is defined and it is not empty." if config.nil?

    config.each do |x, y|
      dbs[x] = SettingsHelper.database_configurations(y)
    end
    dbs.each do |key, settings|
      try = 0
      client = nil
      db_type = settings['db_type']
      case db_type
      when 'sqlserver'
        require 'tiny_tds'
        while try < 2
          begin
            client = SQLDbHandler.new(
                TinyTds::Client.new(host: settings['host'],
                                    username: settings['username'],
                                    password: settings['password'],
                                    database: settings['database'],
                                    appname: settings['appname'],
                                    port: settings['port'],
                                    login_timeout: settings['login_timeout'],
                                    timeout: settings['timeout'],
                                    azure: settings['azure']))

          rescue Exception
            try += 1
            next # it throws an error the first time and that must be negated
          else
            # if no error then the database was found, so you can break
            break
          end
          try += 1
        end
      when 'oracle'
        require 'ruby-oci8'
        client = SQLDbHandler.new(OCIClient.new(
            settings['username'],
            settings['password'],
            settings['host'],
            settings['port'].to_s,
            settings['service_name']))
      when 'postgresql'
        require 'pg'
        client = SQLDbHandler.new(PostgresClient.new(
            settings['database'],
            settings['user'],
            settings['password']))
      when 'mysql'
        require 'mysql2'
        client = SQLDbHandler.new(MySQLClient.new(
            settings['database'],
            settings['user'],
            settings['password']))
      when 'mongoDB'
        require 'mongo'
        Mongo::Logger.logger.level = Logger::WARN
        host = settings['host']
        options = settings.select { |x| x != 'db_type' and x != 'host' }
        client = NoSQLDbHandler.new(Mongo::Client.new(host, options))
      end
      if client.nil?
        raise "Could not connect to database using the #{config} configuration"
      end

      db[key.to_sym] = client
    end
    db
  end


end