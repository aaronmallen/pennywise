# frozen_string_literal: true

require "dry/validation/contract"

module Pennywise
  class Contract < Dry::Validation::Contract
    config.messages.backend = :i18n
    config.messages.top_namespace = :pennywise
    config.messages.load_paths += Dir[Hanami.app.root.join("config/locales/**/*.yml")]
  end
end
