# encoding: utf-8
require 'filepreviews/version'
require 'filepreviews/config'
require 'filepreviews/utils'
require 'filepreviews/http'
require 'filepreviews/response'
require 'ostruct'

# @author Jonah Ruiz <jonah@pixelhipsters.com>
# Main module for FilePreviews.io library
module Filepreviews
  include Filepreviews::Config

  # Facade method to call API response
  # @param url [String] image url to convert
  # @param options [Hash<Symbol>] :metada and :image options
  # @return [Filepreviews::Response] api response object
  def self.generate(url, options = {})
    request_hash = prepare_options(url, options)
    Filepreviews::HTTP.fetch(request_hash)
  end

  protected

  # Prepares url and parameters for request
  #  it calls defaults if nothing is provided
  # @param url [String] url
  # @param params [Hash<symbol>] options
  # @return [OpenStruct] all options as methods
  def self.prepare_options(url, params)
    params = merge_options(params.fetch(:options) { default_options })
    params.merge!(url: url)
    OpenStruct.new(params)
  end

  # Default options to be used in API request
  # @return [Hash<symbol>] default options
  def self.default_options
    { debug: false, metadata: ['all'] }
  end

  # Merges metadata options with supported formats
  # @param options [Hash<symbol>] metadata and optional size
  def self.merge_options(options)
    metadata = (options.fetch(:metadata) & metadata_formats)
    options.store(:metadata, metadata)

    default_options.merge(options)
  end

  # Supported (image) formats in metadata
  # @return [Array] image file extensions
  def self.metadata_formats
    %w(all exif ocr psd)
  end
end
