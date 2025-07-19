# frozen_string_literal: true

require "dry/types"

module Pennywise
  Types = Dry.Types

  module Types
    EmailAddress = Types::String.constrained(format: URI::MailTo::EMAIL_REGEXP)

    IdentityStatus = Types::String.enum("active", "disabled_by_admin", "disabled_by_owner", "invited")

    module Normalized
      EmailAddress = EmailAddress.constructor { |value| value.to_s.downcase.strip }
    end
  end
end
