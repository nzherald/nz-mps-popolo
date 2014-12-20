require 'spec_helper'
require 'support/mps'
require 'support/null_logger'

describe NZMPsPopolo::Extractor do
  subject { NZMPsPopolo::Extractor }

  # There are a number of examples of MP pages with
  # slight HTML variations. We will try to include
  # the ones that cause our parser trouble to test against.
  let(:mps) do
    NZMPsPopolo::TestHelpers.sample_mps.map do |opts|
      instance_double('NZMPsPopolo::MP', opts)
    end

  end

  let(:options) do
    mps.map do |mp|
      VCR.use_cassette(mp.name.downcase.gsub(/[ |']/, '-')) do
        { mp: mp, container: NZMPsPopolo::HTMLParser.new(mp: mp).container }
      end
    end
  end

  it 'does not explode' do
    options.each do |opts|
      ext = subject.new(opts.merge(logger: NullLogger.new))
      %i(honorific entered_parliament_at parliaments_in electoral_history
         current_roles former_roles image links).each do |meth|
        expect { ext.public_send(meth) }.to_not raise_error
      end
    end
  end

  describe 'samples of MP fixtures' do
    subject { NZMPsPopolo::Extractor.new(opts.merge(logger: NullLogger.new)) }

    context 'Gerry Brownlee' do
      let(:opts) do
        options.find { |o| o[:mp].name == 'Gerry Brownlee' }
      end

      it 'returns the correct honorific' do
        expect(subject.honorific).to eq 'Hon'
      end

      it 'returns the correct entered_parliament_at' do
        expect(subject.entered_parliament_at).to eq Date.parse('14 October 1996')
      end

      it 'returns the correct list of parliaments_in' do
        expect(subject.parliaments_in).to eq [45, 46, 47, 48, 49, 50, 51]
      end

      it 'returns the correct electoral history' do
        hist = subject.electoral_history

        expect(hist).to eq([
                             electorate: "Ilam",
                             list: false,
                             party_name: "National Party",
                             start_date: Date.parse('1996-10-14'),
                             end_date: nil
                           ])
      end
    end

  end

end
