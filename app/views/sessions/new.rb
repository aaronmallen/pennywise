# frozen_string_literal: true

module Pennywise
  module Views
    module Sessions
      class New < View
        config.layout = "auth"

        expose(:page_title, layout: true) { "Sign In" }

        expose :errors do |errors: {}|
          errors
        end
      end
    end
  end
end
