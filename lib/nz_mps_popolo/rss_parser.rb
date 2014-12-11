module NZMPsPopolo
  class RSSParser
    URL = 'http://www.parliament.nz/en-nz/syndication?posting=/en-nz/mpp/mps/current/'

    def parse
      Feedjira::Feed.fetch_and_parse URL
    end

    def call
      parse
    end
  end
end
