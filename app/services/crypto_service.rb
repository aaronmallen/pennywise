# frozen_string_literal: true

require "forwardable"

module Pennywise
  module Services
    class CryptoService
      extend Forwardable
      include Deps["services.crypto.hashing_service", "services.crypto.password_service"]

      def_delegator :hashing_service, :generate_sha, :generate_sha_digest
      def_delegator :hashing_service, :verify_sha, :verify_sha_digest
      def_delegator :password_service, :generate_digest, :generate_password_digest
      def_delegator :password_service, :verify, :verify_password_digest
    end
  end
end
