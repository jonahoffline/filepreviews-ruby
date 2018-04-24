require 'ostruct'
require 'cgi'

module Filepreviews
# @author Jonah Ruiz <jonah@pixelhipsters.com>
# Utility module with helper methods
  module Utils
    def self.included(base)
      base.extend(self)
    end

    # Extracts metadata parameters
    # @param metadata [Array] image formats
    # @return [String] metadata url parameters
    def extract_metadata(metadata)
      metadata.to_a
    end

    # Validates page parameters
    # @param pages [Array] page parameters
    # @return [String] page thumbnail parameters
    def validate_pages(pages)
      if !!(pages =~ /,/) || !!(pages =~ /-/) || pages.eql?('all') || pages =~ /\d/
        pages
      end
    end

    # Extracts the desired image size attributes
    # @param size [Hash<Symbol>] desired image :width and :height
    # @return [String] combined width and height size for http request
    def extract_size(size)
      unless size.nil?
        size = OpenStruct.new(size)
        "#{size.width}x#{size.height}"
      end
    end

    # Returns processed options and url as parameters
    # @param params [Hash<Symbol>] :url and :metadata
    # @return [Hash<Symbol>] processed parameters for http request
    def process_params(params)
      parameters = { url: CGI.unescape(params.url) }

      if params.metadata
        parameters[:metadata] = [extract_metadata(params.metadata)]
      end

      parameters
    end
  end
end
