# frozen_string_literal: true

require "dry/monads"

RSpec.configure { |config| config.include Dry::Monads[:result] }
