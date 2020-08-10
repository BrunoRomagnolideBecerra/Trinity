# Class to interact with Jira Zephyr's APIs
# See https://zfjcloud.docs.apiary.io/#reference/ for reference
require 'digest'
require 'jwt'

class ZapiClient

  def initialize
    @secret_key = SettingsHelper.zephyr_settings['secret_key']
    @access_key = SettingsHelper.zephyr_settings['access_key']
    @account_id = SettingsHelper.zephyr_settings['account_id']
    @zapi_cloud_base_url = 'https://prod-api.zephyr4jiracloud.com/connect'.freeze
    @relative_path = 'public/rest/api/1.0/'

  end


  # @param [Cycle] Cycle object containing all the information related to the cycle
  # @return [ResponseHelper, Array<Hash>] Cycles information including executions
  def cycles(cycle_data)
    action_path = @relative_path + 'cycles/search'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path

    parameters = "expand=executionSummaries&projectId=#{cycle_data.project_id}&versionId=#{cycle_data.version_id}"
    canonical_path = 'GET&/' + action_path + '&' + parameters
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)

    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'text/plain'
    request.params.add 'versionId', cycle_data.version_id
    request.params.add 'projectId', cycle_data.project_id
    request.params.add 'expand', 'executionSummaries'

    request.get
  end

  # @param [Cycle] Cycle object containing all the information related to the cycle
  # (See https://zfjcloud.docs.apiary.io/#reference/cycle/creates-new-cycle)
  # name, project_id and version_id are required fields
  # @return [ResponseHelper, body: Hash] Information of the new cycle created
  def create_cycle(cycle_data)
    action_path = @relative_path + 'cycle'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path

    canonical_path = 'POST&/' + action_path + '&'
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)

    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'application/json'

    request.body.add_raw_body cycle_data.to_json(as_string: true)
    request.post
  end

  # @param [Cycle] Cycle object containing all the information related to the cycle.
  # Only version_id, cycle_id and project_id are requried
  # @return [ResponseHelper, String with the result message and timestamp]
  def delete_cycle(cycle_data)
    action_path = @relative_path + 'cycle'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path

    request.append_to_route cycle_data.cycle_id
    parameters = "projectId=#{cycle_data.project_id}&versionId=#{cycle_data.version_id}"
    canonical_path = 'DELETE&/' + action_path + "/#{cycle_data.cycle_id}" + '&' + parameters
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)
    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'text/plain'
    request.params.add 'versionId', cycle_data.version_id
    request.params.add 'projectId', cycle_data.project_id
    request.delete
  end

  # @param [Cycle] Cycle object containing all the information related to the cycle.
  # Only project_id, version_id and cycle_id are required
  # @return [ResponseHelper, body: Hash] Information of the cycle
  def cycle(cycle_data)
    action_path = @relative_path + 'cycle'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path

    request.append_to_route cycle_data.cycle_id
    parameters = "expand=executionSummaries&projectId=#{cycle_data.project_id}&versionId=#{cycle_data.version_id}"
    canonical_path = 'GET&/' + action_path + "/#{cycle_data.cycle_id}" + '&' + parameters
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)
    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'text/plain'
    request.params.add 'versionId', cycle_data.version_id
    request.params.add 'projectId', cycle_data.project_id
    request.params.add 'expand', 'executionSummaries'
    request.get
  end

  # @param [Cycle] Cycle object containing all the information related to the cycle to modify.
  # (See https://zfjcloud.docs.apiary.io/#reference/cycle/update-cycle/update-cycle)
  # name, project_id and version_id are required fields
  # @return [ResponseHelper, body: Hash] The cycle information
  def update_cycle(cycle_data)
    action_path = @relative_path + 'cycle'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path
    request.append_to_route cycle_data.cycle_id
    canonical_path = 'PUT&/' + action_path + "/#{cycle_data.cycle_id}" + '&'
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)

    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'application/json'
    request.body.add_raw_body cycle_data.to_json(as_string: true)
    request.put
  end

  # @param [Cycle] Cycle object containing all the information related to the cycle to modify.
  # (See https://zfjcloud.docs.apiary.io/#reference/execution/add-tests-to-cycle/add-tests-to-cycle, item 1)
  # issues, version_id, project_id, cycle_id are required fields
  # @return [ResponseHelper, String with the result message and timestamp]
  def add_test_to_cycle(input_data, method = 1)
    action_path = @relative_path + 'executions/add/cycle'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path

    request.append_to_route input_data.cycle_id

    canonical_path = 'POST&/' + action_path + "/#{input_data.cycle_id}" + '&'
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)

    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'application/json'
    parsed_json = JSON.parse(input_data.to_json(as_string: true))
    parsed_json["method"] = method
    request.body.add_raw_body parsed_json.to_json
    request.post
  end

  # @param [Execution] Execution object containing all the information related to the execution
  # (See https://zfjcloud.docs.apiary.io/#reference/execution/create-execution/create-execution)
  # project_id, issue_id and version_id are required fields
  # @return [ResponseHelper, body: Hash] Execution data
  def create_execution(execution_data)
    action_path = @relative_path + 'execution'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path

    canonical_path = 'POST&/' + action_path + '&'
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)

    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'application/json'
    request.body.add_raw_body execution_data.to_json(as_string:true)
    request.post

  end

  # @param [Execution] Execution object containing all the information related to the execution to modify
  # (See https://zfjcloud.docs.apiary.io/#reference/execution/update-execution/update-execution)
  # project_id, issue_id, cycle_id and version_id are required fields
  # @return [ResponseHelper, body: Hash] Execution data
  def update_execution(execution_data)
    action_path = @relative_path + 'execution'
    request = ServiceHelper.new base_url: @zapi_cloud_base_url, path: action_path
    request.append_to_route execution_data.id

    canonical_path = 'PUT&/' + action_path + "/#{execution_data.id}" '&'
    jwt_token = generate_jwt_token(@account_id, @secret_key, @access_key, canonical_path)

    request.headers.add('Authorization', 'JWT ' + jwt_token)
    request.headers.add 'zapiAccessKey', @access_key
    request.headers.add 'Content-Type', 'application/json'

    #   body = execution_data.transform_keys { |key| Formatters.snake_case_to_camel_case(key.to_s) }
    request.body.add_raw_body execution_data.to_json(as_string: true)
    request.put
  end

  # @param [Execution] Execution object containing all the information related to the execution
  # (See https://zfjcloud.docs.apiary.io/#reference/execution/create-execution/create-execution)
  # @return [ResponseHelper, body: Hash] Execution data
  def create_and_update_execution_result(execution_data)
    create_execution_response = create_execution(execution_data)
    parsed_response_body = create_execution_response.parsed_body
    raise Exception, "There was an error creating an execution, msg: #{parsed_response_body}" unless create_execution_response.ok?

    execution_data.id = parsed_response_body['execution']['id']
    update_execution execution_data
  end

  private

  def generate_jwt_token(account_id, secret_key, access_key, canonical_path)
    jwt_expire = 36000
    qsh = Digest::SHA256.hexdigest(canonical_path.encode('utf-8'))
    now = Time.now.to_i
    jwt_payload = {
        'sub': account_id,
        'qsh': qsh,
        'iss': access_key,
        'iat': now,
        'exp': now + jwt_expire
    }
    JWT.encode(payload = jwt_payload,
               key = secret_key,
               algorithm = 'HS256',
               headers = {"typ": 'JWT'}).strip
  end

end

