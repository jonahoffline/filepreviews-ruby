require 'spec_helper'

describe Filepreviews::HTTP do
  let(:http) { Filepreviews::HTTP }

  describe '.default_connection' do
    it 'returns a Faraday connection instance' do
      expect(http.default_connection).to be_an_instance_of(Faraday::Connection)
    end

    context 'Overrides Faraday defaults' do
      it 'configures UserAgent header' do
        expect(http.default_connection.headers.fetch('User-Agent'))
          .to eq(Filepreviews::HTTP::USER_AGENT)
      end

      it 'configures the Typhoeus Adapter' do
        expect(http.default_connection.builder.handlers)
          .to include(Faraday::Adapter::Typhoeus)
      end
    end
  end

  describe 'configure_api_auth_header' do
    before(:each) do
      Filepreviews.api_key = nil
      Filepreviews.secret_key = nil
    end

    header = {
      'User-Agent'  => "Filepreviews-Rubygem/#{Filepreviews::VERSION}",
      'Content-Type' => 'application/json'
    }

    context 'when api_key is set' do
      it 'configures the Authorization header' do
        Filepreviews.api_key = '666'
        Filepreviews.secret_key = '000'
        expect(http.default_connection.headers['Authorization'])
          .to eq(Filepreviews::HTTP.generate_auth_key)
      end
    end

    context 'when api_key is not present' do
      it 'does not add the Authorization header' do
        expect(http.default_connection.headers['Authorization']).to be_nil
        expect(http.default_connection.headers).to eq(header)
      end
    end
  end

  describe '.prepare_request' do
    let(:params) { OpenStruct.new(options) }
    let(:request) { http.prepare_request(params) }

    context 'when custom :data is provided' do
      let(:options) do
        {
          url: 'testing.com',
          uploader: { header: 'storage' },
          data: { custom: :value }
        }
      end

      it 'includes the :data hash without changes' do
        expect(request).to include(data: { custom: :value })
      end

      it 'includes the :uploader hash without changes' do
        expect(request).to include(uploader: { header: 'storage' })
      end
    end

    context 'when no custom :data is provided' do
      let(:options) do
        {
          url: 'testing.com'
        }
      end

      it 'does not include the :data key' do
        expect(request).not_to have_key(:data)
      end

      it 'does not include the :uploader key' do
        expect(request).not_to have_key(:uploader)
      end
    end
  end
end
