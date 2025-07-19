# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :identities do
      primary_key :id, :uuid, default: Sequel.function(:gen_random_uuid)

      column :status, :identity_status, index: true, null: false, default: "active"
      column :created_at, :timestamptz, null: false, default: Sequel.function(:now)
      column :updated_at, :timestamptz, null: false, default: Sequel.function(:now)
    end
  end
end
