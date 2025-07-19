# frozen_string_literal: true

module Pennywise
  module Relations
    class Profiles < DB::Relation
      schema :profiles, infer: true do
        attribute :first_name, Types::Normalized::Name
        attribute :last_name, Types::Normalized::Name
        attribute :avatar_url, Types::Normalized::URI.optional

        associations { belongs_to :identity }
      end
    end
  end
end
