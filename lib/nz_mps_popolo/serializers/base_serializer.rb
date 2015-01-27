module NZMPsPopolo
  module Serializers
    module Popolo
      def self.included(base)
        base.send :extend, ClassMethods
        base.send :include, InstanceMethods
      end

      module ClassMethods
        attr_accessor :popolo_serializer

        def popolo_type(type)
          raise ArgumentError, 'Can only be :person, :organization, :membership ' +
            'or :post' unless [:person, :organization,
                               :membership, :post].include? type
          @popolo_type = type
        end
      end
    end

    module InstanceMethods
      def serialize
        @serializer ||= BaseSerializer.serializer(self.class.popolo_type).new(self)
        @serializer.serialize
      end
    end

    class BaseSerializer
      attr_reader :record

      def initialize(record)
        @record = record
      end

      def serialize(options = {})
        serializer.to_popolo
      end

      def self.serializer(type)
        Serializers.const_get(type.to_s.capitalize + 'Serializer')
      end
    end
  end
end
