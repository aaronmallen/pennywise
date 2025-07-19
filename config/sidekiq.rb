# frozen_string_literal: true

require "sidekiq"
require "sidekiq-scheduler"
require "hanami/boot"
require "pennywise/url"

Sidekiq.configure_server { |config| config.redis = { url: Pennywise::URL.redis_url_from_env } }
Sidekiq.configure_client { |config| config.redis = { url: Pennywise::URL.redis_url_from_env } }
