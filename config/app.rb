# frozen_string_literal: true

require "hanami"
require "pennywise/extensions"

module Pennywise
  class App < Hanami::App
    config.actions.sessions =
      :cookie,
      {
        key: "_pennywise_session",
        secret: settings.session_secret,
        expire_after: 31_536_000, # 1 year
      }

    # rubocop:disable Lint/PercentStringArray
    config.actions.content_security_policy[:font_src] = %w['self' https://fonts.gstatic.com].join(" ")
    config.actions.content_security_policy[:style_src] = %w['self' https://fonts.googleapis.com].join(" ")
    # rubocop:enable Lint/PercentStringArray

    environment(:development) { config.logger.options[:colorize] = true }
  end
end
