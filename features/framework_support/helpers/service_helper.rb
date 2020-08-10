require 'httpi'

# Service Class define the communication with RESTful services
# api_url [optional param] , must match a key in the yml environment file being used
#                            otherwise uses the default 'api_url' key in the yml environment file.                    
class ServiceHelper
  attr_reader :request
  attr_reader :params
  attr_reader :body
  attr_reader :headers
  @default_auth = false
  @auth_type = nil

  class << self
    attr_reader :default_auth, :default_user, :default_pass, :default_domain
  end

  def initialize(base_url: nil, path: nil, env_file_entry_url: nil)
    env_file_entry_url.nil? ? prefix = base_url : prefix = SettingsHelper.value_for_key(env_file_entry_url)
    url = path.nil? ? '' : path

    error_msg = 'You do not specified a path or the rest endpoint cannot be found in the restful_api.yml file.
                 Check that you are using the correct one.'
    raise error_msg if url.nil?

    address = if (prefix[-1] == '/' and url[0] == '/')
                base_url[0..-2] + url
              elsif (prefix[-1] == '/' or url[0] == '/')
                base_url + url
              else
                "#{prefix}/#{url}"
              end
    address.delete_suffix! '/' #delete trailing slash
    @request = HTTPI::Request.new(address)
    @params = ParamsHelper.new
    @body = ParamsHelper.new
    @headers = HeadersHelper.new
    if ServiceHelper.default_auth
      @request.auth.send(@auth_type,
                         ServiceHelper.default_user,
                         ServiceHelper.default_pass,
                         ServiceHelper.default_domain)
    end
  end

  def auth(auth_type, user, pass, domain = nil)
    # Supported authentication types: 'basic', 'digest', 'gssnegotiate', 'ssl', 'ntlm'
    @request.auth.send(auth_type, user, pass, domain)
  end

  # Read
  def get
    @request.query = @params.params
    append_headers
    wrap_response HTTPI.get(@request)
  end

  # Create
  def post
    append_params
    append_headers
    wrap_response HTTPI.post(@request)
  end

  # Update/Replace
  def put
    append_params
    append_headers
    wrap_response HTTPI.put(@request)
  end

  # Update/Modify
  def patch
    append_params
    append_headers
    wrap_response HTTPI.patch(@request)
  end

  # Delete
  def delete
    append_params
    append_headers
    wrap_response HTTPI.delete(@request)
  end

  # Append path to route
  def append_to_route(path)
    @request.url.merge!(@request.url.path + "/#{path}")
  end

  def enable_default_auth(user, pass, domain = nil, auth_type)
    supported_types = %w[digest basic ntlm]
    unless supported_types.include?(auth_type)
      raise Exception, "Authentication type must be one of the following values: #{supported_types}"
    end

    @default_auth = true
    @default_user = user
    @default_pass = pass
    @default_domain = domain
    @default_auth_type = auth_type
  end

  def disable_default_auth
    @default_auth = false
    @default_user = nil
    @default_pass = nil
    @default_domain = nil
    @default_auth_type = nil
  end

  private

  def append_params
    @request.query = @params.params

    @request.body =
        if @body.raw_body
          @body.raw_body
        elsif @params.body
          @params.body
        else
          @body.params
        end
  end

  def append_headers
    @request.headers = @headers.headers
  end

  def wrap_response(response)
    ResponseHelper.new response
  end
end
