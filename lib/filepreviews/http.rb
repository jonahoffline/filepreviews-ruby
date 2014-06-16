require 'json'
require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

module Filepreviews
  # @author Jonah Ruiz <jonah@pixelhipsters.com>
  # Contains http helper module
  module HTTP
    API_URL = 'https://api.filepreviews.io/v1/'
    USER_AGENT = "Filepreviews-Rubygem/#{Filepreviews::VERSION}"

    include Filepreviews::Utils

    module_function

    # Returns custom Typhoeus connection configuration
    # @param url [String] API url to be used as base
    # @param debug [Boolean] flag to log responses into STDOUT
    # @return [Typhoeus::Connection] configured http client for requests to API
    def default_connection(url = API_URL, debug = false)
      Faraday.new(url: url) do |conn|
        conn.adapter :typhoeus
        conn.headers[:user_agent] = USER_AGENT
        configure_api_auth_header(conn.headers)
        configure_logger(conn) if debug
      end
    end

    # Configures API Authentication header
    # @param connection_headers [Faraday::Connection] header block
    # @return [Faraday::Connection] 'X-API-KEY' header
    def configure_api_auth_header(connection_headers)
      if (api_key = Filepreviews.api_key)
        connection_headers['X-API-KEY'] = api_key
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
      request.store(:size, extract_size(params.size)) if params.size
      request
    end

    # Returns parsed response from API
    # @return [Filepreviews::Response] json response as callable methods
    def fetch(params)
      response = default_connection(API_URL, params.debug)
                   .get nil, prepare_request(params)
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
