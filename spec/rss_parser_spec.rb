require 'spec_helper'

describe NZMPsPopolo::RSSParser do
  it 'returns an RSS feed' do
    expect(subject.parse).to be_a Feedjira::Parser::Atom
  end

  it 'has a last_modified property' do
    subject.call
    expect(subject.last_modified).to_not be_nil
  end
end
