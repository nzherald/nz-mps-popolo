module NZMPsPopolo
  module Models
    class Party
      include Serializers::Popolo
      attr_reader :name

      popolo_type :organization

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
