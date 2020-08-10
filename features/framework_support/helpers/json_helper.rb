# Module handle json templates and work with json formatting
require_relative 'settings_helper'
module JsonHelper
  @json_file_path = SettingsHelper.trinity_settings('json_templates_path')
  def self.get_template(name)
    return unless File.exist? @json_file_path + "#{name}.json"

    file = File.read(@json_file_path + "#{name}.json")
    begin
      json = JSON.parse(file)
    rescue
      nil
    end
    stringify_json(json)
  end

  def self.stringify_json(json)
    json.each do |key, value|
      if value.is_a? Hash
        stringify_json(value)
      elsif value.is_a? Integer
        json[key] = value.to_s
      end
    end
  end

  def self.save_template(body, name)
    return unless body.any?
    File.write(@json_file_path + "#{name}.json", JSON.pretty_generate(body))
  end
end
