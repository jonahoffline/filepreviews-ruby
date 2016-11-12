require 'json'
require 'base64'
require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

module Filepreviews
  # @author Jonah Ruiz <jonah@pixelhipsters.com>
  # Contains http helper module
  module HTTP
    BASE_URL = 'https://api.filepreviews.io'
    USER_AGENT = "Filepreviews-Rubygem/#{Filepreviews::VERSION}"

    include Filepreviews::Utils

    module_function

    # Returns custom Typhoeus connection configuration
    # @param url [String] API url to be used as base
    # @param debug [Boolean] flag to log responses into STDOUT
    # @return [Typhoeus::Connection] configured http client for requests to API
    def default_connection(url = BASE_URL, debug = false)
      Faraday.new(url: url) do |conn|
        conn.adapter :typhoeus
        conn.headers[:user_agent] = USER_AGENT
        conn.headers[:content_type] = 'application/json'
        configure_api_auth_header(conn.headers)
        configure_logger(conn) if debug
      end
    end

    # Returns API Keys status
    # @return [Boolean] for when API keys are configured
    def api_keys?
      !!(Filepreviews.api_key && Filepreviews.secret_key)
    end

    # Configures API HTTP Basic Authentication
    # @return [String] HTTP Auth string for header
    def generate_auth_key
      key = Base64.encode64("#{Filepreviews.api_key}:#{Filepreviews.secret_key}").gsub(/\n/, '')
      "Basic #{key}"
    end

    # Configures API Authentication header
    # @param connection_headers [Faraday::Connection] header block
    # @return [Faraday::Connection] 'Authorization' header
    def configure_api_auth_header(connection_headers)
      if api_keys?
        connection_headers['Authorization'] = generate_auth_key
      end
    end

    # Configures logger
    # @param connection [Faraday::Connection] connection block
    def configure_logger(connection)
      connection.response :logger
    end

    # Returns processed metadata, and image attributes params
    # @param params [Hash<Symbol>] metadata and image attributes
    # @return [Hash<Symbol>] processed parameters
    def prepare_request(params)
      request = process_params(params)
      request.store(:sizes, [extract_size(params.size)]) if params.size
      request.store(:format, params.format) if params.format
      request.store(:data, params.data) if params.data
      request.store(:uploader, params.uploader) if params.uploader
      request
    end

    # Returns parsed response from API
    # @return [Filepreviews::Response] json response as callable methods
    def fetch(params, endpoint_path = 'previews')
      options = prepare_request(params)
      response = default_connection(BASE_URL, params.debug)
                   .post do |req|
                    req.url("/v2/#{endpoint_path}/")
                     req.body = JSON.generate(options)
                   end

      parse(response.body)
    end

    # Returns callable methods from parsed JSON response
    # @param response_body [String<JSON>] stringified version of json response
    # @return [Filepreviews::Response] json response as callable methods
    def parse(response_body)
      Filepreviews::Response.new(JSON.parse(response_body))
    end
  end
end
