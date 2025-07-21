# frozen_string_literal: true

module UI
  module Components
    class Button < Component
      VARIANT =
        ClassVariants.build do
          base "btn"

          variant active: true, class: "btn-active"
          variant block: true, class: "btn-block"
          variant circle: true, class: "btn-circle"

          variant color: :accent, class: "btn-accent"
          variant color: :error, class: "btn-error"
          variant color: :info, class: "btn-info"
          variant color: :neutral, class: "btn-neutral"
          variant color: :primary, class: "btn-primary"
          variant color: :secondary, class: "btn-secondary"
          variant color: :success, class: "btn-success"
          variant color: :warning, class: "btn-warning"

          variant dash: true, class: "btn-dash"
          variant disabled: true, class: "btn-disabled"
          variant ghost: true, class: "btn-ghost"
          variant link: true, class: "btn-link"
          variant outline: true, class: "btn-outline"

          variant size: :xs, class: "btn-xs"
          variant size: :sm, class: "btn-sm"
          variant size: :md, class: "btn-md"
          variant size: :lg, class: "btn-lg"
          variant size: :xl, class: "btn-xl"

          variant soft: true, class: "btn-soft"
          variant square: true, class: "btn-square"
          variant wide: true, class: "btn-wide"
        end

      attr_reader :active
      attr_reader :block
      attr_reader :circle
      attr_reader :color
      attr_reader :dash
      attr_reader :disabled
      attr_reader :ghost
      attr_reader :link
      attr_reader :outline
      attr_reader :size
      attr_reader :soft
      attr_reader :square
      attr_reader :type
      attr_reader :wide

      def initialize(
        active: false,
        block: false,
        circle: false,
        class: "",
        color: nil,
        dash: false,
        disabled: false,
        ghost: false,
        link: false,
        outline: false,
        size: nil,
        soft: false,
        square: false,
        type: :button,
        wide: false,
        **extra_attributes
      )
        @active = active
        @block = block
        @circle = circle
        @color = color
        @dash = dash
        @disabled = disabled
        @extra_attributes = extra_attributes
        @extra_classes = binding.local_variable_get(:class)
        @ghost = ghost
        @link = link
        @outline = outline
        @size = size
        @soft = soft
        @square = square
        @type = type
        @wide = wide
      end

      def view_template(&)
        button(
          class:
            "#{
              VARIANT.render(
                active:,
                block:,
                circle:,
                color:,
                dash:,
                disabled:,
                ghost:,
                link:,
                outline:,
                size:,
                soft:,
                square:,
                wide:,
              )
            } #{@extra_classes}".strip,
          disabled:,
          type:,
          **@extra_attributes,
          &
        )
      end
    end
  end
end
