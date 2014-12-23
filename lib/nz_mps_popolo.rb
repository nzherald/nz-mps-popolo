require 'nz_mps_popolo/rss_parser'
require 'nz_mps_popolo/html_parser'
require 'nz_mps_popolo/extractor'
require 'nz_mps_popolo/models/mp'
require 'nz_mps_popolo/models/party'
require 'nz_mps_popolo/models/parliament'

# New Zealand Members of Parliament RSS Parser
# Scraper and Popolo spec formatter
module NZMPsPopolo
  def self.run
    parser = RSSParser.new
    parser.call

    mps = parser.mps
    parties = Models::Party.from_mps(mps)
    details = mps.map do |mp|
      html_parser = HTMLParser.new(mp: mp)
      html_parser.call
    end

    { parties: parties, mps: mps, details: details }
  end
end
