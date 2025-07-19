# frozen_string_literal: true

module Pennywise
  module Contracts
    class NewSessionContract < Contract
      config.messages.namespace = :new_session_contract

      params do
        required(:session).filled(:hash) do
          required(:email).filled(Types::EmailAddress)
          required(:password).filled(:string, min_size?: 8)
          required(:remember).filled(:bool)
        end
      end
    end
  end
end
