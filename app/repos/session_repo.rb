# frozen_string_literal: true

module Pennywise
  module Repos
    class SessionRepo < DB::Repo
      commands :create

      def by_pk(id)
        sessions.where(id:).one
      end

      def by_token(token)
        token_digest = generate_token_sha(token)
        sessions.where(token_digest:).one
      end

      def touch_by_token(token)
        sessions
          .where(token_digest: generate_token_sha(token), revoked_at: nil)
          .where { (expired_at > Sequel.function(:now)) | (expired_at =~ nil) }
          .changeset(
            :update,
            last_activity_at: Sequel.function(:now),
            expired_at:
              Sequel.case(
                { { expired_at: nil } => nil },
                Sequel.date_add(Sequel.function(:now), seconds: Hanami.app.settings.session_ttl),
              ),
          )
          .map(:touch)
          .commit
      end

      private

      def generate_token_sha(token)
        Hanami.app["services.crypto_service"].generate_sha_digest(token)
      end
    end
  end
end
