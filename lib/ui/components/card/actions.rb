# frozen_string_literal: true

module UI
  module Components
    class Card
      class Actions < Component
        def initialize(class: "")
          @extra_classes = binding.local_variable_get(:class)
        end

        def view_template(&)
          div(class: "card-actions #{@extra_classes}".strip, &)
        end
      end
    end
  end
end
