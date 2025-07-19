# frozen_string_literal: true

require "digest"

module Pennywise
  module Services
    module Crypto
      class HashingService
        def generate_sha(plaintext)
          Digest::SHA256.hexdigest(plaintext)
        end

        def verify_sha(plaintext, digest) # rubocop:disable Naming/PredicateMethod
          generate_sha(plaintext) == digest
        end
      end
    end
  end
end
