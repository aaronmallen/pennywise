# frozen_string_literal: true

module Pennywise
  module Repos
    class CredentialRepo < DB::Repo
      def by_email(email)
        credentials.where(email:).one
      end

      def by_pk(identity_id)
        credentials.where(identity_id:).one
      end

      def lock(identity_id, lock_until)
        credentials.where(identity_id:).changeset(:update).data(locked_until: lock_until).map(:touch).commit
      end

      def mark_sign_in_failure(identity_id)
        credentials
          .where(identity_id:)
          .changeset(:update)
          .data(failed_attempts: Sequel[:failed_attempts] + 1)
          .map(:touch)
          .commit
      end

      def mark_sign_in_success(identity_id)
        credentials
          .where(identity_id:)
          .changeset(:update)
          .data(failed_attempts: 0, locked_until: nil)
          .map(:touch)
          .commit
      end
    end
  end
end
