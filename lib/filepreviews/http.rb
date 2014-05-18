require 'json'
require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

module Filepreviews
  # @author Jonah Ruiz <jonah@pixelhipsters.com>
  # Contains http helper module
  module HTTP
    API_URL = 'https://blimp-previews.herokuapp.com/'
    USER_AGENT = "Filepreviews-Rubygem/#{Filepreviews::VERSION}"

    include Filepreviews::Utils

    module_function

    # TODO: Fix logger
    # Returns custom Typhoeus connection configuration
    # @param url [String] API url to be used as base
    # @param _debug [Boolean] flag to log responses into STDOUT
    # @return [Typhoeus::Connection] http client for requests to API
    def default_connection(url = API_URL, _debug = true)
      # _logger = debug ? :logger : false

      Faraday.new(url: url) do |conn|
        conn.adapter :typhoeus
        # conn.response _logger
        conn.headers[:user_agent] = USER_AGENT
      end
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
