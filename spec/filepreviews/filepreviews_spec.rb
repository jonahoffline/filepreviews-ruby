require 'spec_helper'

describe Filepreviews do
  let(:file_previews) { Filepreviews }
  let(:sample_img) { 'https://images.pexels.com/photos/876441/pexels-photo-876441.jpeg' }

  it 'keeps it real, you feels me dawg?' do
    expect(true).to eq(true)
  end

  it 'has a version number' do
    expect(Filepreviews::VERSION).not_to be nil
  end

  it 'includes configurable methods from Filepreviews::Config' do
    expect(file_previews.methods).to include(:api_key, :secret_key, :configure)
  end

  describe '.generate' do
    before(:each) do
      Filepreviews.api_key = nil
      Filepreviews.secret_key = nil
    end

    context 'when used without an api key' do
      it 'returns a Filepreviews::Response instance' do
        expect(file_previews.generate(sample_img))
          .to be_an_instance_of(Filepreviews::Response)
      end
    end

    context 'when used with an api key' do
      before(:each) do
        Filepreviews.api_key = ENV['FILEPREVIEWS_API_KEY']
        Filepreviews.secret_key = ENV['FILEPREVIEWS_SECRET_KEY']
      end

      it 'returns a Filepreviews::Response instance' do
        response = file_previews.generate(sample_img)

        expect(response.url).to_not be_nil
        expect(response.id).to_not be_nil
        expect(response).to be_an_instance_of(Filepreviews::Response)
      end

      context 'with additional metadata' do
        it 'returns a Filepreviews::Response instance' do
          response = file_previews.generate(sample_img, {
            options: {
              metadata: [ 'ocr', 'psd', 'exif', 'sketch', 'webpage', 'checksum', 'multimedia' ]
            }
          })

          expect(response.url).to_not be_nil
          expect(response.id).to_not be_nil
          expect(response).to be_an_instance_of(Filepreviews::Response)
        end
      end
    end

    context 'when used with an incorrect api key' do
      it 'returns a Filepreviews::Response instance with an error msg' do
        Filepreviews.api_key = '666'
        Filepreviews.secret_key = '777'
        response = file_previews.generate(sample_img)

        expect(response).to respond_to(:error)
        expect(response.error).to respond_to(:message)
        expect(response.error).to respond_to(:type)

        expect(response.error.message).to eq('Invalid API Key provided.')
        expect(response.error.type).to eq('invalid_request_error')
      end
    end

    context 'when used with incomplete keys' do
      it 'returns a Filepreviews::Response instance with an error msg' do
        Filepreviews.api_key = '666'
        # Filepreviews.secret_key = nil
        response = file_previews.generate(sample_img)

        expect(response).to respond_to(:error)
        expect(response.error).to respond_to(:message)
        expect(response.error).to respond_to(:type)

        expect(response.error.message).to eq('Authentication credentials were not provided.')
        expect(response.error.type).to eq('invalid_request_error')
      end
    end
  end
end
