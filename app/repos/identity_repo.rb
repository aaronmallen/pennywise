# frozen_string_literal: true

module Pennywise
  module Repos
    class IdentityRepo < DB::Repo
      def by_pk(id)
        with_associations.where(id:).one
      end

      private

      def with_associations
        identities
      end
    end
  end
end
