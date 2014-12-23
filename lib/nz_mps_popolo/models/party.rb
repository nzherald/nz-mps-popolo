module NZMPsPopolo
  module Models
    class Party
      attr_reader :name

      def initialize(options)
        @name = options.fetch(:name)
      end

      def self.from_mps(mps)
        names = mps.map { |mp| mp.party }.uniq
        names.map { |p| Party.new(name: p) }
      end
    end
  end
end
