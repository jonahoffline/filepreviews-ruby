require 'spec_helper'

describe Filepreviews do
  let(:file_previews) { Filepreviews }
  let(:sample_img) { 'http://pixelhipsters.com/images/pixelhipster_cat.png' }

  it 'keeps it real, you feels me dawg?' do
    expect(true).to eq(true)
  end

  it 'has a version number' do
    expect(Filepreviews::VERSION).not_to be nil
  end

  it 'includes configurable methods from Filepreviews::Config' do
    expect(file_previews.methods).to include(:api_key, :configure)
  end

  describe '.generate' do
    before(:each) { Filepreviews.api_key = nil }

    context 'when used without an api key' do
      it 'returns a Filepreviews::Response instance' do
        expect(file_previews.generate(sample_img))
          .to be_an_instance_of(Filepreviews::Response)
      end
    end

    context 'when used with an api key' do
      it 'returns a Filepreviews::Response instance' do
        Filepreviews.api_key = ENV['FILEPREVIEWS_API_KEY']
        response = file_previews.generate(sample_img)

        expect(response.metadata_url).to_not be_nil
        expect(response.preview_url).to_not be_nil
        expect(response).to be_an_instance_of(Filepreviews::Response)
      end
    end

    context 'when used with an incorrect api key' do
      it 'returns a Filepreviews::Response instance with an error msg' do
        Filepreviews.api_key = '666'
        response = file_previews.generate(sample_img)

        expect(response).to respond_to(:error)
        expect(response.error).to respond_to(:api_key)
        expect(response.error.api_key).to include('Invalid API Key.')
      end
    end
  end
end
