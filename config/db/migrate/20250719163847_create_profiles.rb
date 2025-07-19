# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :profiles do
      foreign_key :identity_id, :identities, type: :uuid, primary_key: true, on_delete: :cascade

      column :first_name, String, null: false
      column :last_name, String
      column :avatar_url, String
      column :locale, String, null: false, default: "en"
      column :created_at, :timestamptz, null: false, default: Sequel.function(:now)
      column :updated_at, :timestamptz, null: false, default: Sequel.function(:now)
    end
  end
end
