class Container

  WATIR_SEPARATOR = '@watir'.freeze

  def initialize(browser, configuration, value = nil, locator_type = nil)
    !(value.nil? and locator_type.nil?) ? @driver = browser.element(locator_type.to_sym, value) : @driver = browser
    add_controls(configuration)
  end

  def add_controls(configuration)
    configuration.each do |control|

      name = control.first.first
      define_singleton_method(name) { get_control(control.first) }
    end
  end

  def get_control(control)
    name = "@i#{control.first}"
    unless instance_variables.include?(name.to_sym)
      instance_variable_set(name, create_instance(control.last))
    end
    instance_variable_get(name)
  end

  def create_instance(control)
    type = control['control']
    if type.downcase == 'container' and !control.include? 'value'
      value = nil
    else
      Utilities.regex?(control['value']) ? value = Regexp.new(control['value'][1..-2]) : value = control['value']
    end
    locator_type = control['locator_type']
    controls_list = control['elements']

    if type.strip.downcase.end_with? WATIR_SEPARATOR # use watir selector
      use_watir_control = true
      element = type.downcase.split(WATIR_SEPARATOR).first.strip
    end
    if use_watir_control
      @driver.send(element, locator_type.to_sym => value)
    else
      begin
        ctl = Object.const_get(type)
      rescue NameError
        return @browser.send(type.downcase, locator_type.to_sym => value)
      end

      if controls_list.nil?
        ctl.new(@driver, value, locator_type)
      else
        ctl.new(@driver, controls_list, value, locator_type)
      end
    end
  end

  def present?
    @driver.present?
  end

end
