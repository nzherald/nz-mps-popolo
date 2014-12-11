%w(rss bundler open-uri).each { |lib| require lib }
Bundler.require

module NZMPs
  class RSSParser
    URL = 'http://www.parliament.nz/en-nz/syndication?posting=/en-nz/mpp/mps/current/'

    def parse
      open(URL) { |rss| RSS::Parser.parse(rss) }
    end

    def call
      parse
    end
  end
end
