# frozen_string_literal: true

module Pennywise
  module Operations
    class AuthenticateIdentity < Operation
      include Deps[
                "contracts.new_session_contract",
                "i18n.t",
                "repos.credential_repo",
                "repos.identity_repo",
                "services.crypto_service"
              ]

      LOCK_DURATION_SHORT = 300 # 5 minutes
      LOCK_DURATION_MEDIUM = 1800 # 30 minutes
      LOCK_DURATION_LONG = 7200 # 2 hours
      LOCK_DURATION_MAX = 86_400 # 24 hours

      def call(params)
        validated = step validate_params(params)
        credential = step find_credential(validated[:email])

        step verify_credential_is_unlocked(credential)

        identity_id = step verify_password(validated[:password], credential)

        identity_repo.by_pk(identity_id)
      end

      private

      def determine_lock_duration(failed_attempts)
        case failed_attempts
        when 0..2
          0
        when 3..4
          LOCK_DURATION_SHORT
        when 5..9
          LOCK_DURATION_MEDIUM
        when 10..19
          LOCK_DURATION_LONG
        else
          LOCK_DURATION_MAX
        end
      end

      def find_credential(email)
        credential = credential_repo.by_email(email)
        credential ? Success(credential) : Failure(t.call("pennywise.generic_authentication_error"))
      end

      def handle_failed_authentication(credential)
        updated = credential_repo.mark_sign_in_failure(credential.identity_id)

        if should_lock_credential?(updated.failed_attempts)
          lock_credential_and_fail(credential.identity_id, updated.failed_attempts)
        else
          Failure(t.call("pennywise.generic_authentication_error"))
        end
      end

      def handle_successful_authentication(credential)
        credential_repo.mark_sign_in_success(credential.identity_id)
        Success(credential.identity_id)
      end

      def humanize_duration(duration)
        return "1 minute" if duration < 60

        duration_in_minutes = duration / 60

        case duration_in_minutes
        when (0..1)
          "1 minute"
        when (2..59)
          "#{duration_in_minutes} minutes"
        when 60
          "1 hour"
        else
          "#{duration_in_minutes / 60} hours"
        end
      end

      def lock_credential_and_fail(identity_id, failed_attempts)
        lock_duration = determine_lock_duration(failed_attempts)
        credential_repo.lock(identity_id, Time.now.utc + lock_duration)

        Failure(t.call("pennywise.credential_locked", duration: humanize_duration(lock_duration)))
      end

      def should_lock_credential?(failed_attempts)
        failed_attempts >= 3
      end

      def validate_params(params)
        validated = new_session_contract.call(params)
        validated.success? ? Success(validated.to_h[:session]) : Failure(validated.errors.to_h)
      end

      def verify_credential_is_unlocked(credential)
        return Success(credential) unless credential.locked?

        lock_duration = credential.locked_until - Time.now.utc
        Failure(t.call("pennywise.credential_locked", duration: humanize_duration(lock_duration)))
      end

      def verify_password(plaintext, credential)
        if crypto_service.verify_password_digest(plaintext, credential.digest)
          handle_successful_authentication(credential)
        else
          handle_failed_authentication(credential)
        end
      end
    end
  end
end
