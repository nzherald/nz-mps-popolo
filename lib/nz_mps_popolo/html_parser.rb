require 'capybara'
require 'capybara/dsl'
require 'capybara/mechanize'
require 'logger'

module NZMPsPopolo
  BASE_URL = 'http://www.parliament.nz'

  class HTMLParser
    include Capybara::DSL
    CONTAINER_CSS_PATH = '#mainContent #content .contentBody'

    attr_reader :mp, :extractor

    def initialize(options = {})
      @mp = options.fetch(:mp)
      @extractor = options.fetch(:extractor, Extractor)
      Capybara.current_driver = :mechanize
      Capybara.run_server = false
      Capybara.app_host = BASE_URL
      Capybara.app = true
    end

    def call
      process(mp)
    end

    def container
      visit mp.details_url
      find CONTAINER_CSS_PATH
    end

    private

    def process(mp)
      details = {}
      @extractor = extractor.new(container: container, mp: mp)

      %i(honorific entered_parliament_at parliaments_in electoral_history
         current_roles former_roles image links).each do |key|
        details[key] = extractor.public_send(key)
      end

      details
    end
  end
end
