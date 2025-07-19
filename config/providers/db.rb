# frozen_string_literal: true

require "pennywise/url"

Hanami.app.configure_provider :db do
  config.gateway :default do |gateway|
    gateway.database_url = Pennywise::URL.postgres_url_from_env(database: "pennywise")
  end

  if Hanami.env?(:development)
    config.gateway :default do |gateway|
      gateway.database_url = Pennywise::URL.postgres_url_from_env(database: "pennywise_development")
    end
  end

  if Hanami.env?(:test)
    config.gateway :default do |gateway|
      gateway.database_url = Pennywise::URL.postgres_url_from_env(database: "pennywise_test")
    end
  end
end
