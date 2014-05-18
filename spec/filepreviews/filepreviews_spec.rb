require 'spec_helper'

describe Filepreviews do
  let(:file_previews) { Filepreviews }
  let(:sample_img) { 'http://pixelhipsters.com/images/pixelhipster_cat.png' }

  describe '.generate' do
    it 'returns a Filepreviews::Response instance' do
      expect(file_previews.generate(sample_img))
        .to be_an_instance_of(Filepreviews::Response)
    end
  end

  it 'has a version number' do
    expect(Filepreviews::VERSION).not_to be nil
  end

  it 'keeps it real, you feels me dawg?' do
    expect(true).to eq(true)
  end
end
