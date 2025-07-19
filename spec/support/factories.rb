# frozen_string_literal: true

require "faker"
require "rom-factory"

module Pennywise
  module Structs
  end
end

Factory = ROM::Factory.configure { |config| config.rom = Hanami.app["db.rom"] }

Dir[File.expand_path("../factories/**/*.rb", File.dirname(__FILE__))].each { |factory| require factory }
