class CycleBuilder
  attr_reader :cycle

  def self.build
    builder = new
    yield(builder)
    builder.cycle
  end

  def initialize
    @cycle = Cycle.new
  end

  def id(id)
    @cycle.cycle_id = id
  end

  def name(name)
    @cycle.name = name
  end

  def issues(issues_list)
    @cycle.issues = issues_list
  end

  def build(build)
    @cycle.build = build
  end

  def environment(environment)
    @cycle.environment = environment
  end

  def start_date(date)
    @cycle.startDate = date
  end

  def end_date(date)
    @cycle.end_date = date
  end

  def project_id(project_id)
    @cycle.project_id = project_id
  end

  def version_id(version_id)
    @cycle.version_id = version_id
  end

  def description(description)
    @cycle.description = description
  end

end