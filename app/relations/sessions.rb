# frozen_string_literal: true

module Pennywise
  module Relations
    class Sessions < DB::Relation
      schema :sessions, infer: true do
        attribute :ip_address, Types::Normalized::IPAddress.optional
        associations { belongs_to :identity }
      end
    end
  end
end
