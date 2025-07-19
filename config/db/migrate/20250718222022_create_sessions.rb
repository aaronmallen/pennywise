# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :sessions do
      primary_key :id, :uuid, default: Sequel.function(:gen_random_uuid)

      foreign_key :identity_id, :identities, type: :uuid, index: true, null: false, on_delete: :cascade

      column :token_digest, String, index: { unique: true }, null: false, size: 64
      column :ip_address, String
      column :user_agent, String
      column :expired_at, :timestamptz, index: true
      column :revoked_at, :timestamptz, index: true
      column :last_activity_at, :timestamptz, null: false, default: Sequel.function(:now)
      column :created_at, :timestamptz, null: false, default: Sequel.function(:now)
      column :updated_at, :timestamptz, null: false, default: Sequel.function(:now)
    end
  end
end
