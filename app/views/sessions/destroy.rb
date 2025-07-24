# frozen_string_literal: true

module Pennywise
  module Views
    module Sessions
      class Destroy < View
        config.layout = :auth

        def view_template
          Loader(size: :xl)
        end
      end
    end
  end
end
