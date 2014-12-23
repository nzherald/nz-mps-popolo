require 'spec_helper'

describe NZMPsPopolo::RSSParser do
  subject do
    NZMPsPopolo::RSSParser.new(feed_url: "file://#{File.expand_path('../../fixtures/feed.rss', __FILE__)}")
  end

  before do
    subject.call
  end

  it 'returns an RSS feed' do
    expect(subject.feed).to be_a Feedjira::Parser::Atom
  end

  it 'has a last_modified property' do
    expect(subject.last_modified).to_not be_nil
  end

  it 'holds an an array of MPs' do
    expect(subject.mps).to be_a Array
    expect(subject.mps.map(&:class).uniq).to eq [NZMPsPopolo::Models::MP]
  end
end
