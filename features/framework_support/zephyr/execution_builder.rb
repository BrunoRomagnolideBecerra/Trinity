class ExecutionBuilder
  attr_reader :execution

  def self.build
    builder = new
    yield(builder)
    builder.execution
  end

  def initialize
    @execution = Execution.new
  end

  def id(id)
    @execution.id = id
  end

  def status(status)
    @execution.status = {id: status}
  end

  def issue_id(issue_id)
    @execution.issue_id = issue_id
  end

  def assignee(assignee)
    @execution.assignee = assignee
  end

  def assignee_type(assignee_type)
    @execution.assignee_type = assignee_type
  end

  def project_id(project_id)
    @execution.project_id = project_id
  end

  def version_id(version_id)
    @execution.version_id = version_id
  end

  def cycle_id(cycle_id)
    @execution.cycle_id = cycle_id
  end


end