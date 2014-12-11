require 'spec_helper'

describe NZMPsPopolo::RSSParser do
  it 'returns an RSS feed' do
    expect(subject.call).to be_a Feedjira::Parser::Atom
  end

  it 'has a last_modified property'
end
