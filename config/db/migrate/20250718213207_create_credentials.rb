# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :credentials do
      foreign_key :identity_id, :identities, type: :uuid, primary_key: true, on_delete: :cascade

      column :email, String, index: { unique: true }, null: false, size: 320
      column :digest, String, null: false
      column :failed_attempts, Integer, null: false, default: 0
      column :locked_until, :timestamptz
      column :digest_changed_at, :timestamptz, null: false, default: Sequel.function(:now)
      column :created_at, :timestamptz, null: false, default: Sequel.function(:now)
      column :updated_at, :timestamptz, null: false, default: Sequel.function(:now)
    end
  end
end
