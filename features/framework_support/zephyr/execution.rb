require 'json'

class Execution
  attr_accessor :id, :status, :cycle_id, :assignee, :assignee_type, :issue_id, :project_id, :version_id

  def as_json(options = {})
    {
        id: @id,
        status: @status,
        cycleId: @cycle_id,
        assignee: @assignee,
        assignee_type: @assignee_type,
        issueId: @issue_id,
        projectId: @project_id,
        versionId: @version_id
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