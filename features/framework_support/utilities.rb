# Utility class that contains helper methods
class Utilities

  def self.regex?(string)
    string[0] and string[-1] == '/'
  end

  def self.clean_cache(browser)
    browser.execute_script('try { window.localStorage.clear(); window.sessionStorage.clear(); } catch(e){console.log(e);}')
    browser.cookies.clear
  end

  def self.last_month_no_padding
    (DateTime.now << 1).strftime('%-m/%-d/%Y')
  end

  def self.last_month(date_format = '%m/%d/%Y')
    (DateTime.now << 1).strftime(date_format)
  end

  def self.tomorrow(date_format = '%m/%d/%Y')
    (Time.now + (1 * 24 * 60 * 60)).strftime(date_format)
  end

  def self.today(date_format = '%m/%d/%Y')
    Time.now.strftime(date_format)
  end

  def self.today_no_padding
    Time.now.strftime('%-m/%-d/%Y')
  end

  def self.today_international_format
    Time.now.strftime('%Y-%m-%d')
  end

  def self.last_week
    (DateTime.now - 7).strftime('%m/%d/%Y')
  end

  def self.today_utc
    Time.now.utc
  end

  def self.yesterday_utc
    (Time.now - (1 * 24 * 60 * 60)).utc
  end

  def self.past_years(current_date, times = nil)
    times ||= 1
    times.to_i.times do
      current_date = current_date.prev_year
    end
    current_date
  end

  def self.recorded_date(time_now = '%m/%d/%Y %I:%M %p')
    complete_time_date = DateTime.strptime(time_now, '%m/%d/%Y %I:%M %p')
    date = complete_time_date.strftime('%m/%d/%Y ') + complete_time_date.strftime('%I:%M %p')
    unless complete_time_date.strftime('%I:%M %p').sub!(/^0/, '').nil?
      date = complete_time_date.strftime('%m/%d/%Y ') + complete_time_date.strftime('%I:%M %p').sub!(/^0/, '')
    end
    date
  end

  def self.repeat_date(complete_time_date = '%m/%d/%Y %I:%M %p', months)
    repeat_date = DateTime.strptime(complete_time_date, '%m/%d/%Y %I:%M %p') >> months.to_i
    date = repeat_date.strftime('%m/%d/%Y ') + repeat_date.strftime('%I:%M %p')
    unless repeat_date.strftime('%I:%M %p').sub!(/^0/, '').nil?
      date = repeat_date.strftime('%m/%d/%Y ') + repeat_date.strftime('%I:%M %p').sub!(/^0/, '')
    end
    date
  end

  def self.minutes_in_past(minutes, date_format = '%m/%d/%Y %I:%M %p')
    (Time.now - (minutes * 60)).strftime(date_format)
  end

  def self.yesterday(pattern = '%m/%d/%Y')
    (Time.now - (1 * 24 * 60 * 60)).strftime(pattern)
  end

  def self.yesterday_no_padding
    yesterday('%-m/%-d/%Y')
  end

  def self.days_in_past(days, date_format = '%m/%d/%Y')
    (Time.now - (days * 24 * 60 * 60)).strftime(date_format)
  end

  def self.service_exists?(service_name)
    system "sc.exe query \"#{service_name}\""
  end

  def self.service_running?(service_name, machine_name = '')
    if system "sc.exe #{machine_name} query \"#{service_name}\" | find \"RUNNING\""
      return true
    elsif start_service(service_name, machine_name)
      return true
    end

    false
  end

  def self.service_stopped?(service_name, machine_name = '')
    if system "sc.exe #{machine_name} query \"#{service_name}\" | find \"STOPPED\""
      return true
    elsif stop_service(service_name, machine_name)
      return true
    end

    false
  end

  # start a system service
  # @param [String] service_name the name of the service to start
  # @param [String] machine_name the name of the machine on which to start the service
  # @param [Boolean] wait_for_state false to return immediately, true to wait for service to transition to RUNNING
  # @return [Boolean] output of last run system command
  def self.start_service(service_name, machine_name = '', wait_for_state = false)
    set_service_state service_name, true, machine_name, wait_for_state
  end

  # stop a system service
  # @param [String] service_name the name of the service to stop
  # @param [String] machine_name the name of the machine on which to stop the service
  # @param [Boolean] wait_for_state false to return immediately, true to wait for service to transition to STOPPED
  # @return [Boolean] output of last run system command
  def self.stop_service(service_name, machine_name = '', wait_for_state = false)
    set_service_state service_name, false, machine_name, wait_for_state
  end

  # stop a system service
  # @param [String] service_name the name of the service to stop
  # @param [Boolean] start true to start the service, false to stop the service
  # @param [String] machine_name the name of the machine on which to stop the service
  # @param [Boolean] wait_for_state false to return immediately, true to wait for service to transition to STOPPED
  # @return [Boolean] output of last run system command
  def self.set_service_state(service_name, start = true, machine_name = '', wait_for_state = false)
    service_name = "\"#{service_name}\""
    cmd = start ? 'start' : 'stop'
    state = start ? '"RUNNING"' : '"STOPPED"'
    # noinspection RubyResolve
    unless machine_name.empty? or machine_name.start_with? '\\\\'
      machine_name.prepend('\\\\')
    end
    ok = system "sc.exe #{machine_name} #{cmd} #{service_name}"
    return ok unless wait_for_state

    start = Time.now
    while Time.now - start < 60 do
      sleep 1
      ok = system "sc.exe #{machine_name} query #{service_name} | find #{state}"
      break if ok
    end
    ok
  end

  # stop and then start a system service
  # @param [String] service_name the name of the service to restart
  # @param [String] machine_name the name of the machine on which to restart the service
  # @param [Boolean] wait_for_state false to return immediately, true to wait for service to transition to STOPPED / RUNNING
  # @return [Boolean] output of last run system command
  def self.restart_service(service_name, machine_name = '', wait_for_state = false)
    stop_service(service_name, machine_name, wait_for_state)
    start_service(service_name, machine_name, wait_for_state)
  end

  # Ugly method needed because Parse service is not interactahiing correctly with the console
  def self.restart_parse_service(service_name)
    count = 0
    stop_service(service_name)
    while (system "sc.exe query \"#{service_name}\" | find \"STOPPED\"") == false do
      sleep 1
      count += 1
      return false if count == 60
    end
    start_service(service_name)
    while (system "sc.exe query \"#{service_name}\" | find \"RUNNING\"") == false do
      sleep 1
      count += 1
      return false if count == 60
    end
    true
  end

  def self.validata_data_results(table, response)
    index = 0

    table.hashes.each do |row|
      if response[index] == row
        index += 1
      else
        return response[index].to_s
      end
    end
    true
  end

  def self.host_name
    hostname = IO.popen('hostname').readlines
    FileHelper.normalize_hostname(hostname)
  end

  def self.run_scheduled_task(task_name)
    system 'schtasks.exe /run /tn "' + task_name + '"'
  end

  def self.wait_for_job(finish_time)
    sleep finish_time
  end

  #sends in a strptime pattern and a variable to be converted into a Time variable
  # and offsets the time according to the time zone
  def self.date_time_conversion(time_str, pattern)
    DateTime.strptime(time_str, pattern).to_time - Time.zone_offset("#{Time.now.getlocal.zone}")
  end

  def self.date_time_conversion_with_offset(time_str, pattern, offset)
    DateTime.strptime(time_str, pattern).to_time - Time.zone_offset(offset)
  end

  # used to convert times formatted as: '06/04/2018 03:50:21 PM' that are commonly found in the grid
  def self.convert_grid_time(time_str)
    # clone so you don't change the passed in value
    time_str = time_str.clone
    year = time_str.match(%r{/\d{4}}).to_s
    time_str.slice!(year)
    year.slice!('/')
    Time.parse(time_str.prepend("#{year}/"))
  end

  def self.date_valid?(date)
    pattern = %r{^(1[0-2]|0[1-9])/(3[01]|[12][0-9]|0[1-9])/[0-9]{4}}i
    pattern == date
  end

  def self.date_with_hour_valid?(date)
    pattern = %r{^(1[0-2]|0[1-9])/(3[01]|[12][0-9]|0[1-9])/([0-9]{4})\s([0-1][0-9]|[2][0-3]):[0-5][0-9]\s[AM|PM]}i
    pattern == date
  end

  # get the first IPv4 address of the local machine
  # @return [String] the IPv4 address of the local machine
  def self.local_ip
    ip_config = `ipconfig`.encode('UTF-8', 'Windows-1252')
    ip_config.match(/IPv4.*:(.*)/).captures.first.strip
  end

  def self.convert_string_to_time(time)
    time = DateTime.parse(time)
    time
  end

  # convert an integer value to an array of bits
  def self.int_to_bits(int, size = 8)
    (0...size).map { |n| int[n] }
  end

  # convert an array of bits to an integer value
  def self.bits_to_int(bits)
    bits.reverse.join.to_i(2)
  end

  # convert an hex digit to an array of bits
  # if using this you may need to reverse bit order to have the bit index correct (0=most significant as it returns now)
  def self.hex_to_bits(hex, size = 8)
    hex.to_s.to_i(16).to_s(2).rjust(size, '0').reverse
  end

  #convert an array of bits to an array of bytes
  def self.bits_to_bytes(bits, size = 4)
    bytes = []
    i = 0
    while i < size
      bytes.push(bits[(0 + (i * 8))...(8 + (i * 8))].reverse.join.to_i(2))
      i += 1
    end
    bytes
  end

  def self.int_to_bytes(value, bit_size = 32, byte_size = 4)
    bits = Utilities.int_to_bits(value, bit_size)
    Utilities.bits_to_bytes(bits, byte_size)
  end

  def self.kill_thread(thread)
    while thread.alive?
      Thread.kill thread
    end
    err_msg = "Something strange happened with your thread. It's status is \"#{thread.status}\""
    raise err_msg if thread.alive?
  end

  def self.save_value_in_hash(key, value)
    @info = {} if @info.nil?
    @info[key] = value
  end

  def self.get_value_from_hash(key)
    @info = {} if @info.nil?
    @info[key]
  end

  def self.get_keys_from_hash
    @info = {} if @info.nil?
    @info.keys
  end

  #Give an array of values and a dropdown control, returns true if all the values from the array are in the dropdown
  def self.dropdown_contains_values(dropdown, values)
    values.each do |opt|
      return false unless dropdown.option(opt.strip)
    end
    true
  end

  def self.compare_hash_values(hash_a, hash_b, key)
    hash_a[key].eql? hash_b[key]
  end

  # takes a time variable and converts it to a time that is usable in an sql database
  def self.convert_to_db_time(time)
    time.strftime('%F %T')
  end

  def self.string_time_delta_days(str1, str2, format1 = '%m/%d/%Y', format2 = '%m/%d/%Y')
    # Computes the difference between two string formatted dates str1 and str2, i.e. str1 - str2
    # and returns the result in days
    time1 = Utilities.date_time_conversion(str1, format1)
    time2 = Utilities.date_time_conversion(str2, format2)
    (((time1 - time2) / 60) / 60) / 24
  end

  def self.find_element_in_all_frames(browser, &block)
    element = block.call browser
    return element if element.present?

    browser.frames.each do |frame|
      result = find_element_in_all_frames frame, &block
      return result if result
    end
    nil

  end

  def self.consecutive?(arr)
    are_consecutive = true
    arr.each_cons(2) { |x, y| are_consecutive = false unless (y - x) == 1 }
    are_consecutive
  end


  # execute a block of code until it either succeeds or the timeout expires
  def self.time_box_retry(timeout = 30, evaluate_result = false, polling_every_seconds = 1, error_msg: "")
    e = nil
    result = nil
    start_time = Time.now.to_i
    while (Time.now.to_i - start_time) < timeout
      begin
        result = yield
        e = nil
        break if result
      rescue NameError => err
        raise err # fail on missing method/attribute immediately
      rescue StandardError => err
        e = err
      end
      sleep polling_every_seconds
    end
    raise e unless e.nil?
    if evaluate_result
      # decide whether or not an error message needs thrown
      if error_msg.empty?
        raise unless result
      else
        raise error_msg unless result
      end
    end
  end


end


# Class that checks if a String is numeric
class String
  def numeric?

    !Float(self).nil?
  rescue
    false

  end

  # returns true if the String can be converted to an integer via the .to_i function
  def is_i?
    /\A[-+]?\d+\z/ === self
  end

  def titleize
    split.map(&:capitalize).join(' ')
  end

  def remove_all_whitespace
    gsub(/[[:space:]]/, '')
  end
end
