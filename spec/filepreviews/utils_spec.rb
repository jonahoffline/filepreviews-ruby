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
        .to eq(url: url, metadata: ['png'])
    end
  end

  describe '.extract_size' do
    it 'returns extracted image parameters combined' do
      size = { width: 320, height: 240 }
      expect(Kawaii.new.extract_size(size)).to eq('320x240')
    end
  end

  describe '.validate_pages' do
    context 'when called with range parameters (1-3)' do
      it 'validates page parameters' do
        expect(Kawaii.new.validate_pages('1-3'))
          .to eq('1-3')
      end
    end

    context 'when called with specific pages' do
      it 'validates page parameters' do
        expect(Kawaii.new.validate_pages('1,3,5'))
          .to eq('1,3,5')
      end
    end

    context 'when called with specific pages' do
      it 'validates page parameters' do
        expect(Kawaii.new.validate_pages('all')).to eq('all')
      end
    end
  end
end
