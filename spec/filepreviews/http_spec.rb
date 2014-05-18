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
end
