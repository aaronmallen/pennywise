# frozen_string_literal: true

module Pennywise
  module Repos
    class CredentialRepo < DB::Repo
      def by_pk(identity_id)
        credentials.where(identity_id:).one
      end
    end
  end
end
