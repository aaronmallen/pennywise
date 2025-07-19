# frozen_string_literal: true

Hanami.app.register_provider :redis do
  prepare do
    require "pennywise/url"
    require "redis"
  end

  start { register :redis, Redis.new(url: Pennywise::URL.redis_url_from_env) }
end
