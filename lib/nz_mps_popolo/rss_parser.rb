module NZMPsPopolo
  class RSSParser
    attr_reader :feed, :last_modified

    URL = 'http://www.parliament.nz/en-nz/syndication?posting=/en-nz/mpp/mps/current/'

    def parse
      @feed = Feedjira::Feed.fetch_and_parse URL
    end

    def call
      parse
      @last_modified = feed.last_modified
    end
  end
end
