# frozen_string_literal: true

require "database_cleaner/sequel"

RSpec.configure do |config|
  all_databases =
    lambda do
      slices = [Hanami.app] + Hanami.app.slices.with_nested

      slices
        .each_with_object([]) do |slice, dbs|
          next unless slice.key?("db.rom")

          dbs.concat slice["db.rom"].gateways.values.map(&:connection)
        end
        .uniq
    end

  config.before :suite do
    all_databases.call.each do |db|
      DatabaseCleaner[:sequel, db: db].clean_with :truncation, except: ["schema_migrations"]
    end
  end

  config.before do |example|
    strategy = example.metadata[:js] ? :truncation : :transaction

    all_databases.call.each do |db|
      DatabaseCleaner[:sequel, db: db].strategy = strategy
      DatabaseCleaner[:sequel, db: db].start
    end
  end

  config.after { all_databases.call.each { |db| DatabaseCleaner[:sequel, db: db].clean } }
end
