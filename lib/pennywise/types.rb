# frozen_string_literal: true

require "dry/types"

module Pennywise
  Types = Dry.Types

  module Types
    IdentityStatus = Types::String.enum("active", "disabled_by_admin", "disabled_by_owner", "invited")
  end
end
