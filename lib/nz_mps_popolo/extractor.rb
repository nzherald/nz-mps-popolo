# coding: utf-8
module NZMPsPopolo
  class Extractor
    attr_reader :container, :mp, :logger

    MEMBER_OF_FOLLOWING_REGEX = /Member of.*following Parliaments:?/
    ENTERED_PARLIAMENT_REGEX = /Entered Parliament[:|;]? /

    def initialize(options)
      @container = options.fetch(:container)
      @mp        = options.fetch(:mp)
      @logger    = options.fetch(:logger, Logger.new(STDOUT))
      logger.info "Extracting #{mp.name}"
    end

    def honorific
      titled_name = container.find('.copy .section h1').text
      (titled_name.sub(mp.name, '')).strip
    end

    def entered_parliament_at
      str = introblock_list_items.detect { |l| l.text =~ ENTERED_PARLIAMENT_REGEX }
            .text
            .sub(ENTERED_PARLIAMENT_REGEX, '')

      logger.debug 'Entered Parliament:'
      logger.debug str
      Date.parse str
    end

    def parliaments_in
      str = introblock_list_items.detect { |l| l.text =~ MEMBER_OF_FOLLOWING_REGEX }
            .text
            .sub(MEMBER_OF_FOLLOWING_REGEX, '')

      logger.debug 'Parliamentary terms:'
      logger.debug str
      str.split(' and ').map { |s| s.split(',') }.flatten.map(&:to_i)
    end

    def electoral_history
      rows = container.find(:xpath, './/div[1]/div[1]/table/tbody').all('tr')
      rows.map do |row|
        cells = row.all('td')
        next if cells[2].text.strip == 'Date'
        generate_parliamentary_membership(cells)
      end
    end

    def current_roles
      uls = container.find('.copy > div > div:nth-child(3)').all('ul')
      uls.map do |ul|
        ul.all('li').map(&:text)
      end.flatten
    end

    def former_roles
      roles = {}

      begin
        sections = container.find(:xpath, './/div[1]/div[3]').all('.section')
      rescue Capybara::ElementNotFound
        return
      end

      sections.each do |section|
        # Guard required as Chris Hipkins page has an empty div
        next unless section.has_selector?('ul')

        type = section.all('h3, h4').last.text
        roles[type] = []
        section.all('ul').each do |ul|
          ul.all('li').each do |li|
            roles[type] << li.text
          end
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

    def introblock_list_items
      uls = container.find('.copy > div.section:first-of-type > div.section:first-of-type').all('ul')
      uls.map { |ul| ul.all('li').to_a }.flatten
    end
  end
end
