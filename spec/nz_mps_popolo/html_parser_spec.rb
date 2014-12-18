require 'spec_helper'
require 'support/mock_extractor'

describe NZMPsPopolo::HTMLParser do
  subject { NZMPsPopolo::HTMLParser }

  it 'requires an mp' do
    expect { subject.new(wrong_key: 'foo') }.to raise_error KeyError
  end

  context 'with an MP' do
    let(:mp) { double }
    subject do
      NZMPsPopolo::HTMLParser.new(extractor: NZMPsPopolo::MockExtractor,
                                  mp: mp)
    end

    it 'processes an MP' do
      expect(mp).to receive(:details_url) { 'http://parliament.govt.nz/en-nz/mpp/mps/current/51MP3011/ardern-jacinda' }
      VCR.use_cassette('jacinda_ardern') do
        subject.call
      end
      expect(subject.extractor.methods_called).to eq %i(honorific entered_parliament_at
                                                        parliaments_in electoral_history
                                                        current_roles former_roles image
                                                        links)
    end

  end

end
