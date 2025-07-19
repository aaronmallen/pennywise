# frozen_string_literal: true

module Pennywise
  class Settings < Hanami::Settings
    setting :session_secret, constructor: Types::Strict::String.constrained(size: 128)
    setting :session_ttl, constructor: Types::Coercible::Integer
  end
end
