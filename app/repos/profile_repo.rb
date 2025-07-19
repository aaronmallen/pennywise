# frozen_string_literal: true

module Pennywise
  module Repos
    class ProfileRepo < DB::Repo
      def by_pk(identity_id)
        profiles.where(identity_id:).one
      end
    end
  end
end
