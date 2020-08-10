# Scenario Helper class
class ScenarioHelper
  attr_reader :scenario
  attr_reader :start_time

  def initialize(scenario)
    @scenario = scenario
    @start_time = Time.now
  end

  def tag?(tag_name)
    @scenario.source_tag_names.each do |tag|
      return true if tag.to_s.eql? tag_name
    end

    false
  end

  def browser_needed?
    @scenario.source_tag_names.each do |tag|
      return false if ['@NoBrowserNeeded'].include? tag
    end
    true
  end

  def mobile?
    @scenario.source_tag_names.each do |tag|
      return true if ['@Mobile'].include? tag
    end
    false
  end

  def tag?(tag_name)
    @scenario.source_tag_names.each do |tag|
      return true if tag.to_s.eql? tag_name
    end

    false
  end

end
