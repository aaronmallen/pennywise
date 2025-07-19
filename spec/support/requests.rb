# frozen_string_literal: true

require "rack/test"

RSpec.configure { |config| config.include Rack::Test::Methods, type: :request }
