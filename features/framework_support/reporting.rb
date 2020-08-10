require 'report_builder'

# class for generating reports
class Reporting
  TITLE = 'Automated Test Report'.freeze
  COLOR = 'indigo'.freeze

  # generate report
  def self.run(json_file)

    generate_report Dir.pwd, json_file
  rescue => e
    puts "Error creating report. Reason: #{e.message}"

  end

  # generate HTML report from Cucumber json output file
  # @param [String] report_dir directory containing report.json
  # @param [String] json_file name of Cucumber json test result file, defaults to report.json
  # @param [Boolean] add_env_info add test environment details when true
  # @param [String] working directory
  def self.generate_report(report_dir, json_file, add_env_info = true)
    json_path = File.join report_dir, json_file
    unless File.exist? json_path
      raise "Json report data does not exist at #{json_path}"
    end

    init_dir = Dir.pwd
    begin
      Dir.chdir report_dir
      ReportBuilder.report_title = TITLE
      ReportBuilder.report_path = "test_#{File.basename json_file, '.*'}"
      ReportBuilder.additional_info = generate_info report_dir if add_env_info
      ReportBuilder.color = COLOR
      ReportBuilder.build_report
    ensure
      Dir.chdir init_dir
    end
  end

  private

  def self.generate_info(test_run_directory)
    info = {}
    add_testenv_info info, test_run_directory
    info
  end

  def self.add_testenv_info(info, test_run_directory)
    info[:Website] = build_link SettingsHelper.environment['base_url'] unless SettingsHelper.environment['base_url'].nil?
    info[:Browser] = SettingsHelper.environment['browser']&.capitalize
    info[:Device] = SettingsHelper.environment['device']&.capitalize
    if SettingsHelper.mobile?
      info[:PlatformName] = SettingsHelper.current_device_profile['platformName']&.capitalize
    else
      case info[:Browser].downcase
      when 'firefox'
        if OS.windows?
          info[:BrowserVersion] = `cmd /c "C:\\Program Files\\Mozilla Firefox\\firefox.exe" -v | more`
        elsif OS.linux?
          info[:BrowserVersion] = `firefox --v`.match(/(?<version>\d+(\.\d+)*)/)['version']
        elsif OS.mac?
          info[:BrowserVersion] = `/Applications/Firefox.app/Contents/MacOS/firefox --v`.match(/(?<version>\d+(\.\d+)*)/)['version']
        end
      when 'chrome'
        info[:ChromeSwitches] = build_ul(SettingsHelper.chrome_switches) unless SettingsHelper.chrome_switches.nil? || SettingsHelper.chrome_switches.empty?
        info[:ChromeOptions] = SettingsHelper.chrome_options unless SettingsHelper.chrome_options.nil? || SettingsHelper.chrome_options.empty?
        SettingsHelper.chrome_options unless SettingsHelper.chrome_options.nil? || SettingsHelper.chrome_options.empty?
        if OS.windows?
          info[:BrowserVersion] = `reg query "HKEY_CURRENT_USER\\Software\\Google\\Chrome\\BLBeacon" /v version`.split("\n").last.match(/REG_SZ\s+(?<version>(.*))/)['version']
          info[:ChromeDriverVersion] = `chromedriver --version`.match(/(?<version>\d+(\.\d+)*)/)['version']
        elsif OS.linux?
          info[:BrowserVersion] = `google-chrome --version`.match(/(?<version>\d+(\.\d+)*)/)['version']
        elsif OS.mac?
          info[:BrowserVersion] = `/Applications/"Google Chrome.app"/Contents/MacOS/"Google Chrome" --version`.match(/(?<version>\d+(\.\d+)*)/)['version']
        end
      when 'safari'
        info[:BrowserVersion] = `mdls -name kMDItemVersion /Applications/Safari.app`.match(/(?<version>\d+(\.\d+)*)/)['version']
      end
    end
    info[:RubyVersion] = `ruby --version`.chomp
  end

  def self.build_link(url, text = nil, target = '_blank')
    text = url if text.nil?
    "<a href='#{url}' target='#{target}'>#{text}</a>"
  end

  def self.build_ul(list)
    "<ul><li>#{list.join('</li><li>')}</li></ul>"
  end
end