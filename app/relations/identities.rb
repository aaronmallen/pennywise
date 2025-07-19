# frozen_string_literal: true

module Pennywise
  module Relations
    class Identities < DB::Relation
      schema :identities, infer: true do
        associations do
          has_many :sessions

          has_one :credential
          has_one :profile
        end
      end
    end
  end
end
