# frozen_string_literal: true

require "forwardable"

module Pennywise
  module Services
    class CryptoService
      extend Forwardable
      include Deps["services.crypto.password_service"]

      def_delegator :password_service, :generate_digest, :generate_password_digest
      def_delegator :password_service, :verify, :verify_password_digest
    end
  end
end
