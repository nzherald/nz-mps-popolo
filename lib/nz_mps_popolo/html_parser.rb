require 'capybara'
require 'capybara/dsl'
require 'capybara/mechanize'
require 'logger'

module NZMPsPopolo
  BASE_URL = 'http://www.parliament.nz'

  class HTMLParser
    include Capybara::DSL

    attr_reader :mp

    def initialize(options = {})
      @mp = options.fetch(:mp)
      Capybara.current_driver = :mechanize
      Capybara.run_server = false
      Capybara.app_host = BASE_URL
      Capybara.app = true
    end

    def call
      process(mp)
    end

    private

    def process(mp)
      details = { mp: mp }

      visit mp.details_url
      container = find '#mainContent #content .contentBody'
      extractor = Extractor.new(container: container, mp: mp)

      %i(honorific entered_parliament_at parliaments_in electoral_history
         current_roles former_roles image links).each do |key|
        details[key] = extractor.public_send(key)
      end

      details
    end
  end
end
