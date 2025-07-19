# frozen_string_literal: true

module Pennywise
  module Structs
    class Identity < DB::Struct
      def active?
        Types::IdentityStatus["active"] == status
      end
    end
  end
end
