# frozen_string_literal: true

source "https://rubygems.org"

ruby "~> 3.4"

group :development, :production, :staging, :test do
  gem "argon2"
  gem "class_variants"
  gem "dry-operation"
  gem "dry-types"
  gem "hanami"
  gem "hanami-assets"
  gem "hanami-controller"
  gem "hanami-db"
  gem "hanami-router"
  gem "hanami-validations"
  gem "hanami-view"
  gem "i18n"
  gem "pg"
  gem "phlex"
  gem "phlex-slotable"
  gem "puma"
  gem "redis"
  gem "sidekiq"
  gem "sidekiq-scheduler"
end

group :cli, :development do
  gem "hanami-reloader"
end

group :cli, :development, :test do
  gem "hanami-rspec"
end

group :development do
  gem "hanami-webconsole"
end

group :development, :test do
  gem "dotenv"
end

group :lint do
  gem "prettier_print"
  gem "rubocop"
  gem "rubocop-capybara"
  gem "rubocop-ordered_methods"
  gem "rubocop-performance"
  gem "rubocop-rspec"
  gem "syntax_tree"
  gem "syntax_tree-css"
  gem "syntax_tree-tailwindcss"
  gem "w_syntax_tree-erb"
end

group :test do
  gem "capybara"
  gem "database_cleaner-sequel"
  gem "faker"
  gem "rack-test"
  gem "rom-factory"
  gem "simplecov"
end
