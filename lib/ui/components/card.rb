# frozen_string_literal: true

module UI
  module Components
    class Card < Component
      include Phlex::Slotable

      VARIANT =
        ClassVariants.build do
          base "card"

          variant border: true, class: "card-border"
          variant dash: true, class: "card-dash"

          variant size: :xs, class: "card-xs"
          variant size: :sm, class: "card-sm"
          variant size: :md, class: "card-md"
          variant size: :lg, class: "card-lg"
          variant size: :xl, class: "card-xl"
        end

      slot :title, Title
      slot :body, Body
      slot :actions, Actions

      attr_reader :border
      attr_reader :dash
      attr_reader :size

      def initialize(border: false, class: "", dash: false, size: nil)
        @border = border
        @dash = dash
        @extra_classes = binding.local_variable_get(:class)
        @size = size
      end

      def view_template
        div(class: "#{VARIANT.render(border:, dash:, size:)} #{@extra_classes}".strip) do
          render title_slot if title_slot?
          render body_slot if body_slot?
          render actions_slot if actions_slot?
          yield if block_given? && !title_slot? && !body_slot? && !actions_slot?
        end
      end
    end
  end
end
