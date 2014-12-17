require 'feedjira'

module NZMPsPopolo
  class RSSParser
    attr_reader :feed, :last_modified, :mps

    URL = 'http://www.parliament.nz/en-nz/syndication?posting=/en-nz/mpp/mps/current/'

    def parse
      @feed = Feedjira::Feed.fetch_and_parse URL
      @mps = generate_from_feed
    end

    def call
      parse
      @last_modified = feed.last_modified
    end

    private

    def parse_party_and_electorate(electorate_details)
      party, electorate = electorate_details.split(',').map(&:strip)
      if electorate == 'List'
        { electorate: nil, party: party, list: true }
      else
        { electorate: electorate, party: party, list: false }
      end
    end

    def generate_from_feed
      feed.entries.map do |item|
        MP.new(parse_feed_item(item))
      end
    end

    def parse_feed_item(item)
      last_name, first_names = item.title.split(',').map(&:strip)
      {
        entry_id: item.entry_id,
        first_names: first_names,
        last_name: last_name,
        details_url: item.links.first
      }.merge(parse_party_and_electorate(item.content))
    end
  end
end
