# frozen_string_literal: true

module UI
  module Components
    class Icon < Component
      VARIANT =
        ClassVariants.build do
          base "fa-sharp"

          variant light: true, class: "fa-light"
          variant regular: true, class: "fa-regular"
          variant solid: true, class: "fa-solid"
          variant thin: true, class: "fa-thin"

          variant size: :xxs, class: "fa-2xs"
          variant size: :xs, class: "fa-xs"
          variant size: :sm, class: "fa-sm"
          variant size: :lg, class: "fa-lg"
          variant size: :xl, class: "fa-xl"
          variant size: :xxl, class: "fa-2xl"
        end

      attr_reader :light
      attr_reader :regular
      attr_reader :size
      attr_reader :solid
      attr_reader :thin

      def initialize(
        icon,
        class: "",
        light: false,
        regular: false,
        size: nil,
        solid: false,
        thin: false,
        **extra_options
      )
        @extra_attributes = extra_options
        @extra_classes = "fa-#{icon} #{binding.local_variable_get(:class)}".strip
        @light = light
        @regular = regular
        @size = size
        @solid = solid
        @thin = thin
      end

      def view_template
        i(
          class: "#{VARIANT.render(light:, regular:, size:, solid:, thin:)} #{@extra_classes}".strip,
          **@extra_attributes,
        )
      end
    end
  end
end
