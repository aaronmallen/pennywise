# frozen_string_literal: true

module Pennywise
  module Structs
    class Credential < DB::Struct
      def locked?
        !locked_until.nil? && locked_until >= Time.now.utc
      end
    end
  end
end
