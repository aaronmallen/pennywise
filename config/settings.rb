# frozen_string_literal: true

module Pennywise
  class Settings < Hanami::Settings
    setting :session_secret, constructor: Types::Strict::String.constrained(size: 128)
  end
end
