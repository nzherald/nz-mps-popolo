require 'bundler'
Bundler.require

require_relative './nz_mps_popolo/rss_parser'
require_relative './nz_mps_popolo/mp'
require_relative './nz_mps_popolo/party'


# New Zealand Members of Parliament RSS Parser
# Scraper and Popolo spec formatter
module NZMPsPopolo
  def self.run
    parser = RSSParser.new
    parser.call

  end
end
