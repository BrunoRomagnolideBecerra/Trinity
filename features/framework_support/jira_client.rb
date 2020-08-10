# Class to interact with Jira's APIs
require_relative 'helpers/settings_helper'
require_relative 'helpers/service_helper'
class JiraClient


  def initialize
    @jira_url = SettingsHelper.jira_settings['jira_url']
    @jira_user = SettingsHelper.jira_settings['jira_user']
    @jira_token = SettingsHelper.jira_settings['jira_token']
  end

  # Returns the Test Id that corresponds to the given test key
  # @param [String] test_key (e.g TEST-123, AUT-232)
  # @return [String] The test id
  def test_id(test_key)
    request = ServiceHelper.new base_url: @jira_url, path: "rest/api/3/issue"
    request.auth 'basic', @jira_user, @jira_token
    request.headers.add 'Accept', 'application/json'
    request.append_to_route test_key
    response = request.get
    raise Exception, response.body unless response.ok?

    response.parsed_body['id']
  end

  # Returns the Project Id that corresponds to the given project key
  # @param [String] project_key (e.g: IAM; MET)
  # @return [String] The project id
  def project_id(project_key)
    project_info(project_key)['id']
  end

  # Returns the project information
  # @param [String] project_key. The project key of your board
  # @return [Hash] Project's information. (id, description, issueTypes, versions, style, etc)
  def project_info(project_key)
    request = ServiceHelper.new base_url: @jira_url, path: "rest/api/3/project"
    request.auth 'basic', @jira_user, @jira_token
    request.headers.add 'Accept', 'application/json'
    request.append_to_route project_key
    response = request.get
    raise Exception, response.body unless response.ok?

    response.parsed_body
  end

  # Returns all the versions of a project
  # @param [String] project_key. The project key of your board
  # @return [Array<Hash>] A list of the project versions and their related information
  def versions_id(project_key)
    request = ServiceHelper.new base_url: @jira_url, path: "rest/api/3/project/"
    request.auth 'basic', @jira_user, @jira_token
    request.headers.add 'Accept', 'application/json'
    request.append_to_route "#{project_key}/versions"
    response = request.get
    raise Exception, response.body unless response.ok?

    response.parsed_body
  end
end
