require 'fileutils'
require 'csv'
require 'nokogiri'

# FileHelper class contains functions to manage operations with files
class FileHelper
  @path_separators = Regexp.new /[\/,\\]/

  def self.get_script_execution_path
    Dir.pwd
  end

  def self.reverse_message(message, message_array)
    #I search in the array starting from the latest element since I'm looking for a recent event
    message_array.reverse.each { |each|
      if each.to_s.include?(message)
        return each.to_s
      end
    }
  end

  def self.normalize_string(string)
    string = string.gsub("\n", '')
    string = string.gsub("\\", '')
  end

  def self.normalize_message_type(message_type)
    if message_type.include? '/'
      return message_type.sub! '/', '-'
    else
      return message_type
    end
  end

  def self.normalize_message_with_path(message)
    return message.gsub(/\\/,'\&\&\&\&')
  end

  def self.normalize_hostname(string)
    string = string.to_s
    string = string.gsub('"', '')
    string = string.gsub('[', '')
    string = string.gsub(']', '')
    string = string.gsub('{', '')
    string = string.gsub('}', '')
    string = string.gsub('=>', '')
    string = string.gsub('\n', '')
  end

  def self.copy_all_folder_files(source_folder, destination_folder)
    files_list = Dir.entries( source_folder ).select{ |f| File.file? File.join( source_folder, f ) }
    files_list.each do |file_name|
      FileUtils.cp(File.join( source_folder, file_name ), destination_folder)
    end
  end

  #create the full path to a directory unless it already exists
  def self.safe_mkdir(dir)
    FileUtils.mkdir_p dir unless Dir.exist? dir
  end

  def self.read_csv_content(file_path)
    return IO.readlines(file_path)
  end

  def self.delete_folder(folder_path)
    FileUtils.rm_rf(folder_path)
  end

  def self.directory_exists?(directory)
    File.directory?(directory)
  end

  def self.string_exist(string, path)
    File.open (File.expand_path(path)) do |file|
      return true if file.find { |line| line =~ /#{string}/ }
    end
  end

  def self.remove_file(path)
    if File.file?(File.expand_path(path))
      FileUtils.rm(File.expand_path(path))
    end
  end

  def self.read_last_lines(path, lines)
    IO.readlines(path).last(lines)
  end

  # removes invalid characters for a file name
  # also strips whitespace and periods from the end of a file name (as those are forbidden)
  def self.to_valid_filename(str)
    return "" if str.nil? || str.empty?
    cleaned = str.gsub(/[\/\\*?"<>:|]/, '')
    while cleaned[-1].match(/\.|\s/) do
      cleaned.strip! if cleaned[-1].eql? ' '
      cleaned[-1] = '' if cleaned[-1].eql? '.'
    end
    return cleaned
  end

  # checks for /, \, :, *, ?, ", >, <, | characters
  # also checks for the string to end with whitespace or a period
  # if any of those conditions are true it will return false
  # if it passes without a match, it is true
  # it checks if the returned value is an array with one blank string in it, if so that means it passes
  def self.valid_filename?(str)
    str.match(/\/|\\|:|\*|\?|"|<|>|\||\s$|[.]$/).nil?
  end

  def self.path_to_relative(path)
    path.sub(Dir.pwd + '/', '')
  end

  # @return [String] the path that services log data at, obtained from within the Global.xml file
  def self.get_log_path_from_global
    global_xml = File.open(Utilities.get_global_path) { |f| Nokogiri::XML(f) }
    global_xml.xpath('/StarSettings/StaticSettings/GlobalSettings/DefaultLogPath').text
  end

end
