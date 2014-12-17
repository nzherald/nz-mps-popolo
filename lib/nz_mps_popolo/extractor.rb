# coding: utf-8
module NZMPsPopolo
  class Extractor
    attr_reader :container, :mp, :logger

    def initialize(options)
      @container = options.fetch(:container)
      @mp        = options.fetch(:mp)
      @logger    = options.fetch(:logger, Logger.new(STDOUT))
    end

    def honorific
      titled_name = container.find '.copy .section h1'
      (titled_name - mp.name).strip
    end

    def entered_parliament_at
      str = container.find(:xpath, './/div[1]/div[1]/ul[1]/li[1]').text
      Date.parse str.sub(/Entered Parliament: /, '')
    end

    def parliaments_in
      str = container.find(:xpath, './/div[1]/div[1]/ul[1]/li[2]')
      str = str.sub(/Member of the following Parliaments: /, '')
      str.split(' and ').map { |s| s.split(', ') }.flatten.map(&:to_i)
    end

    def electoral_history
      rows = container.find(:xpath, './/div[1]/div[1]/table/tbody').all('tr')
      rows.map do |row|
        cells = row.all('td')
        generate_parliamentary_membership(cells)
      end
    end

    def current_roles
      container.find(:xpath, './/div[1]/div[2]/ul').all('li').map(&:text)
    end

    def former_roles
      roles = {}
      sections = container.find(:xpath, './/div[1]/div[3]').all('.section')

      sections.each do |section|
        type = section.find('h3').text
        roles[type] = []
        section.find('ul').all('li').each do |li|
          roles[type] << li.text
        end
      end

      roles
    end

    def image
      NZMPsPopolo::BASE_URL + container.find('td.image img')[:src]
    rescue Capybara::ElementNotFound
      logger.warn "#{mp.name} does not have a photo"
    end

    def links
      container.find('.infoTiles tbody:last-child tr:last-child ul').all('li a').map do |a|
        { text: a.text, link: a[:href] }
      end
    end

    private

    def generate_parliamentary_membership(cells)
      electorate = cells[0].text
      list = electorate == 'List'
      electorate = list ? nil : electorate

      party_name = cells[1].text
      date_range = cells[2].text.sub(/–/, '-').strip.split('-').map(&:strip)
      start_date, end_date = date_range.map { |str| Date.parse(str) }

      { electorate: electorate, list: list, party_name: party_name,
        start_date: start_date, end_date: end_date }
    end
  end
end
