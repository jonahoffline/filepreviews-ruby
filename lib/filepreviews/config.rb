module Filepreviews
  # @author Jonah Ruiz <jonah@pixelhipsters.com>
  # Configurable module for API key and options
  module Config
    def self.included(base)
      base.extend(self)
    end

    # @!attribute api_key, :secret_key
    # @return [String] API/Secret key to be used
    attr_accessor :api_key, :secret_key

    # Configures api_key and options
    #   Usage example:
    #     Filepreviews.configure do |config|
    #       config.api_key = 'your_api_key_here'
    #       config.secret_key = 'your_api_key_here'
    #     end
    #
    #   Alternate way:
    #     Filepreviews.api_key = ENV['YOUR_API_KEY']
    #     Filepreviews.secret_key = ENV['YOUR_SECRET_KEY']
    #
    # @param <api_key> [String] api/secret key to use
    def configure
      yield self if block_given?
    end
  end
end
