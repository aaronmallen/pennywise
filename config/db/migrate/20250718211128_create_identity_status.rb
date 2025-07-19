# frozen_string_literal: true

ROM::SQL.migration { change { create_enum :identity_status, %w[active disabled_by_admin disabled_by_owner invited] } }
