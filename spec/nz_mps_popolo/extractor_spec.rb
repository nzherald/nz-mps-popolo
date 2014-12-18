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

end
