# frozen_string_literal: true

require "argon2"

module Pennywise
  module Services
    module Crypto
      class PasswordService
        def generate_digest(plaintext)
          Argon2::Password.create(plaintext, profile: :rfc_9106_high_memory)
        end

        def verify(plaintext, digest)
          Argon2::Password.verify_password(plaintext, digest)
        end
      end
    end
  end
end
