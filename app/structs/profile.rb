# frozen_string_literal: true

module Pennywise
  module Structs
    class Profile < DB::Struct
      def full_name
        [first_name, last_name].compact.reject(&:empty?).join(" ")
      end
    end
  end
end
