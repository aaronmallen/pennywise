# frozen_string_literal: true

module Pennywise
  class Routes < Hanami::Routes
    root to: "budgets.index"
  end
end
