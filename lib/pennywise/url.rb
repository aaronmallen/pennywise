# frozen_string_literal: true

module Pennywise
  module URL
    POSTGRES_TEMPLATE = "postgres://%<user>s:%<password>s@%<host>s:%<port>s/%<database>s"
    REDIS_TEMPLATE = "redis://%<password>s@%<host>s:%<port>s/%<database>s"

    class << self
      def postgres_url_from_env(**overrides)
        defaults = {
          database: ENV.fetch("DATABASE_NAME", "postgres"),
          host: ENV.fetch("DATABASE_HOST", "localhost"),
          password: ENV.fetch("DATABASE_PASSWORD", "password"),
          port: ENV.fetch("DATABASE_PORT", 5432),
          user: ENV.fetch("DATABASE_USER", "postgres"),
        }.freeze

        format(POSTGRES_TEMPLATE, defaults.merge(overrides))
      end

      def redis_url_from_env(**overrides)
        defaults = {
          database: ENV.fetch("REDIS_DATABASE", 0),
          host: ENV.fetch("REDIS_HOST", "localhost"),
          password: ENV.fetch("REDIS_PASSWORD", "password"),
          port: ENV.fetch("REDIS_PORT", 6379),
        }.freeze

        format(REDIS_TEMPLATE, defaults.merge(overrides))
      end
    end
  end
end
