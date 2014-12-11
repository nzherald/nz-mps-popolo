require 'bundler'
Bundler.require

require_relative './nz_mps_popolo/rss_parser'

# New Zealand Members of Parliament RSS Parser
# Scraper and Popolo spec formatter
module NZMPsPopolo
  def self.run
    RSSParser.new.call
  end
end