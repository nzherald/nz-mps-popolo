module NZMPsPopolo
  module Serializers
    class OrganizationSerializer < BaseSerializer
      def to_popolo
        {
          id: record.name,
          name: record.name
        }
      end
    end
  end
end
