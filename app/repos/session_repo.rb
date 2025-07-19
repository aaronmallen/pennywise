# frozen_string_literal: true

module Pennywise
  module Repos
    class SessionRepo < DB::Repo
      def by_pk(id)
        sessions.where(id:).one
      end

      def by_token(token)
        token_digest = generate_token_sha(token)
        sessions.where(token_digest:).one
      end

      private

      def generate_token_sha(token)
        Hanami.app["services.crypto_service"].generate_sha_digest(token)
      end
    end
  end
end
