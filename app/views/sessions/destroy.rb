# frozen_string_literal: true

module Pennywise
  module Views
    module Sessions
      class Destroy < View
        config.layout = "auth"
      end
    end
  end
end
