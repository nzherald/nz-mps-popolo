module NZMPsPopolo
  module Serializers
    class PersonSerializer < BaseSerializer
      def to_popolo
        {
          id: record.entry_id,
          name: record.name
        }
      end
    end
  end
end
