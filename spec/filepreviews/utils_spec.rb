require 'spec_helper'

# Dummy class for testing Utils module
class Kawaii
  include Filepreviews::Utils
end

describe Filepreviews::Utils do
  let(:kawaii) { Kawaii.new }

  describe '.process_params' do
    it 'returns extracted parameter hash with :url and :metadata' do
      url = 'https://www.filepicker.io/api/file/0ehaqJwCTSq4P6jMrix6'
      params = OpenStruct.new(url: url, metadata: ['png'])

      expect(kawaii.process_params(params))
        .to eq(url: url, metadata: 'png')
    end
  end

  describe '.extract_size' do
    it 'returns extracted image parameters combined' do
      size = { width: 320, height: 240 }
      expect(Kawaii.new.extract_size(size)).to eq('320x240')
    end
  end
end
