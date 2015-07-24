require 'spec_helper'

# Dummy class for testing ::Config module
class Kawaii
  extend Filepreviews::Config
end

describe Filepreviews::Config do
  let(:config) { Kawaii }

  describe '.api_key' do
    it 'sets api key' do
      config.api_key = '666'
      expect(config.api_key).to eq('666')
    end
  end

  describe '.secret_key' do
    it 'sets secret key' do
      config.secret_key = '666'
      expect(config.secret_key).to eq('666')
    end
  end

  describe '.configure' do
    it 'sets the api_key when used with a block' do
      config.configure do |conf|
        conf.api_key = 'kawaii!'
        conf.secret_key = 'not-kawaii!'
      end

      expect(config.api_key).to eq('kawaii!')
      expect(config.secret_key).to eq('not-kawaii!')
    end
  end
end
