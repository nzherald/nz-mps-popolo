module NZMPsPopolo
  module Serializers
    class MembershipSerializer < BaseSerializer
      def to_popolo
        raise NotImplementedError
      end
    end
  end
end
