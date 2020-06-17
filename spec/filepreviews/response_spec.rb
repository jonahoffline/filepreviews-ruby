require 'spec_helper'

describe Filepreviews::Response do
  let(:response) { Filepreviews::Response }

  describe '.new' do
    it 'returns an Response instance' do
      expect(response.new({})).to be_an_instance_of(Filepreviews::Response)
    end

    it 'calls responsify' do
      json = JSON.parse({hey: "wow"}.to_json)
      expect(response.new(json).hey).to eq("wow")
    end
  end

  describe '.responsify' do
    json = JSON.parse({url: "filepreviews.io", testing: true}.to_json)

    context 'when a Hash or JSON response is passed' do
      it 'transforms body attributes into callable methods' do
        responsify = response.new(json)

        expect(responsify.url).to eq("filepreviews.io")
        expect(responsify.testing).to eq(true)
      end
    end
  end

end
