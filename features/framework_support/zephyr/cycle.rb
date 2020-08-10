require 'json'

class Cycle
  attr_accessor :cycle_id, :name, :build, :environment, :description, :start_date, :end_date, :project_id, :version_id, :issues

  def as_json(options = {})
    {
        name: @name,
        cycleId: @cycle_id,
        build: @build,
        environment: @environment,
        description: @description,
        startDate: @start_date,
        endDate: @end_date,
        projectId: @project_id,
        versionId: @version_id,
        issues: @issues
    }
  end

  def to_json(*options, as_string: false)
    result = JSON.parse(as_json(*options).reject { |_, v| v.nil? }.to_json(*options))
    if as_string
      result.to_json
    else
      result
    end
  end

end