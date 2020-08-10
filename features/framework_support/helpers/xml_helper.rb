require 'nokogiri'

class XMLHelper


  def self.parse_xml_file(file_name)
    Nokogiri::XML.parse(read_xml(file_name))
  end

  def self.get_xml_node(file_name, xpath)
    parsed_xml = Nokogiri::XML.parse(read_xml(file_name))
    parsed_xml = parsed_xml.xpath(xpath)
    parsed_xml
  end

  def self.normalize_xml(string)
    string = string.gsub("\n", '')
    string.gsub('\\', '')
  end


  private

  def self.read_xml(file_name)
    File.read(file_name)
  end

end