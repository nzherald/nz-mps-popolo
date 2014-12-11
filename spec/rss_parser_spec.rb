require 'spec_helper'
require_relative '../scraper'

describe NZMPs::RSSParser do
  it 'returns an RSS feed' do
    expect(subject.call).to be_a RSS::Atom::Feed
  end
end
