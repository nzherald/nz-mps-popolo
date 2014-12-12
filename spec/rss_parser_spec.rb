require 'spec_helper'

describe NZMPsPopolo::RSSParser do
  before { subject.call }

  it 'returns an RSS feed' do
    expect(subject.feed).to be_a Feedjira::Parser::Atom
  end

  it 'has a last_modified property' do
    expect(subject.last_modified).to_not be_nil
  end

  it 'holds an an array of MPs' do
    expect(subject.mps).to be_a Array
    expect(subject.mps.map(&:class).uniq).to eq [NZMPsPopolo::MP]
  end
end
