$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'filepreviews'

RSpec.configure do |config|
  config.order = 'random'
end
