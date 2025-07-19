# frozen_string_literal: true

module Pennywise
  module Relations
    class Identities < DB::Relation
      schema :identities, infer: true
    end
  end
end
