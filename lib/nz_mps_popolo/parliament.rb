module NZMPsPopolo
  class Parliament
    include Comparable
    attr_reader :number

    def initialize(options)
      @number = options.fetch(:number)
      fail ArgumentError, 'Number must be an integer' unless number.is_a? Integer
    end

    def <=>(other)
      self.number <=> other.number
    end

    def ordinal_number
      str = number.to_s
      return str + 'th' if str =~ /(11|12|13)$/
      str + case str[-1]
            when '1' then 'st'
            when '2' then 'nd'
            when '3' then 'rd'
            else 'th'
            end
    end
  end
end
