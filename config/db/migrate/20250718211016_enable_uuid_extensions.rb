# frozen_string_literal: true

ROM::SQL.migration do
  up { run "CREATE EXTENSION IF NOT EXISTS \"pgcrypto\"" }

  down { run "DROP EXTENSION IF EXISTS \"pgcrypto\"" }
end
