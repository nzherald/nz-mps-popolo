module NZMPsPopolo
  module Serializers
    class BaseSerializer
      attr_reader :record

      def initialize(record)
        @record = record
      end

      class << self
        attr_reader :defined_popolo_type

        def popolo_type(type)
          raise ArgumentError, 'Can only be :person, :organization, :membership ' +
                               'or :post' unless [:person, :organization,
                                                  :membership, :post].include? type
          @defined_popolo_type = type
        end
      end

      def serialize(options = {})
        klass = Object.const_get(defined_popolo_type.to_s.capitalize + 'Serializer')
        klass.to_popolo
      end

    end
  end
end
