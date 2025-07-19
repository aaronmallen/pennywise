# frozen_string_literal: true

module Pennywise
  module Operations
    class CreateSession < Operation
      include Deps["repos.session_repo", "services.crypto_service", "settings"]

      def call(identity, request, remember: false)
        request_attributes = step extract_session_attributes_from_request(request)
        token, token_digest = step generate_token
        expired_at = step generate_expiration(!remember)

        step create_session(identity_id: identity.id, token_digest:, expired_at:, **request_attributes)

        token
      end

      private

      def create_session(attributes)
        Success(session_repo.create(attributes.compact))
      rescue StandardError => e
        Failure(e)
      end

      def generate_expiration(expire)
        return Success(nil) unless expire

        Success(Time.now.utc + settings.session_ttl)
      end

      def generate_token
        token = crypto_service.generate_secret
        digest = crypto_service.generate_sha_digest(token)
        Success([token, digest])
      end

      def extract_session_attributes_from_request(request)
        ip_address =
          (
            request.get_header("HTTP_X_FORWARDED_FOR")&.split(",")&.first || request.get_header("HTTP_X_REAL_IP") ||
              request.get_header("REMOTE_ADDR") || request.ip
          )&.strip

        user_agent = request.get_header("HTTP_USER_AGENT")

        Success({ ip_address:, user_agent: }.compact)
      end
    end
  end
end
