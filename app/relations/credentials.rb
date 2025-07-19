# frozen_string_literal: true

module Pennywise
  module Relations
    class Credentials < DB::Relation
      schema :credentials, infer: true do
        attribute :email, Types::Normalized::EmailAddress

        associations { belongs_to :identity }
      end
    end
  end
end
