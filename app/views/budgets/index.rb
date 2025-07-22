# frozen_string_literal: true

module Pennywise
  module Views
    module Budgets
      class Index < View
        def view_template
          h1 { self.class.name }
        end
      end
    end
  end
end
