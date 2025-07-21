# frozen_string_literal: true

require "class_variants"
require "phlex"
require "phlex/slotable"

module UI
  class Component < Phlex::HTML
    include Components
  end
end
