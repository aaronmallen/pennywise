# frozen_string_literal: true

require "dry/types"
require "resolv"

module Pennywise
  Types = Dry.Types

  module Types
    EmailAddress = Types::String.constrained(format: URI::MailTo::EMAIL_REGEXP)

    IdentityStatus = Types::String.enum("active", "disabled_by_admin", "disabled_by_owner", "invited")

    IPAddress = Types::String.constrained(format: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex))

    module Normalized
      EmailAddress = EmailAddress.constructor { |value| value.to_s.downcase.strip }

      IPAddress = IPAddress.constructor(&:strip)
    end
  end
end
