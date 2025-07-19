# frozen_string_literal: true

module Pennywise
  module Structs
    class Session < DB::Struct
      def expired?
        !expired_at.nil? && expired_at <= Time.now.utc
      end

      def revoked?
        !revoked_at.nil? && revoked_at <= Time.now.utc
      end
    end
  end
end
