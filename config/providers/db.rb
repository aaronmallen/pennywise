# frozen_string_literal: true

require "pennywise/url"

Hanami.app.configure_provider :db do
  database =
    case Hanami.env.to_sym
    when :development
      "pennywise_development"
    when :test
      "pennywise_test"
    else
      "pennywise"
    end

  config.gateway :default do |gateway|
    gateway.database_url = Pennywise::URL.postgres_url_from_env(database:)
    gateway.adapter(:sql) { |sql| sql.extension(:date_arithmetic) }
  end
end
