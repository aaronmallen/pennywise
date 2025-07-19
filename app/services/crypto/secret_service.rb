# frozen_string_literal: true

module Pennywise
  module Services
    module Crypto
      class SecretService
        DEFAULT_SECRET_BYTES = 32

        def generate(bytes = DEFAULT_SECRET_BYTES)
          SecureRandom.hex(bytes)
        end
      end
    end
  end
end
