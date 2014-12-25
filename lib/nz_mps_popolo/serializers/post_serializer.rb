module NZMPsPopolo
  module Serializers
    class PostSerializer < BaseSerializer
      def to_popolo
        raise NotImplementedError
      end
    end
  end
end
