require 'spec_helper'

describe NZMPsPopolo::HTMLParser do
  subject { NZMPsPopolo::HTMLParser }

  it 'requires an mp' do
    expect { subject.new(wrong_key: 'foo') }.to raise_error KeyError
  end
end
