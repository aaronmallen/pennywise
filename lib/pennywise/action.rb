# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "dry/monads"

module Pennywise
  class Action < Hanami::Action
    include AuthHelpers
    include Dry::Monads[:result]
  end
end
