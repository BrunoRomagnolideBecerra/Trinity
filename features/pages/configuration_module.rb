module ConfigurationModule

  WATIR_SEPARATOR = '@watir'.freeze

  def add_controls(name)
    # Add controls of the parent page
    if SettingsHelper.page_configuration(name).include? 'extends'
      parent_page = SettingsHelper.page_configuration(name)['extends']
      self.add_controls parent_page
    end
    controls = SettingsHelper.page_configuration(name)['controls']
    controls.each do |control|
      name = control.first
      define_singleton_method(name) { get_control(control) }
    end
  end

  def get_control(control)
    name = "@i#{control.first}"
    instance_variable_set(name, create_instance(control)) # unless self.instance_variables.include?(name.to_sym) Removed to avoid xpath issues
    instance_variable_get(name)
  end

  def create_instance(control)
    type = control.last['control']
    if type.downcase == 'container' and !control.last.include? 'value'
      value = nil
    else
      Utilities.regex?(control.last['value']) ? value = Regexp.new(control.last['value'][1..-2]) : value = control.last['value']
    end

    locator_type = control.last['locator_type']
    controls_list = control.last['elements']

    if type.strip.downcase.end_with? WATIR_SEPARATOR # use watir selector
      use_watir_control = true
      element = type.downcase.split(WATIR_SEPARATOR).first.strip
    end
    if use_watir_control
      @browser.send(element, locator_type.to_sym => value)
    else
      begin
        ctl = Object.const_get(type)
      rescue NameError # Let's try if the watir element
        return @browser.send(type.downcase, locator_type.to_sym => value)
      end

      if controls_list.nil?
        ctl.new(@browser, value, locator_type)
      else
        ctl.new(@browser, controls_list, value, locator_type)
      end
    end
  end

  def page_file_exists?(name)
    SettingsHelper.page_configurations.include? name
  end

  def page
    self
  end

end
