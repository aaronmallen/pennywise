# frozen_string_literal: true

module UI
  module Components
    class Loader < Component
      VARIANT =
        ClassVariants.build do
          base "loading"

          variant size: :xs, class: "loading-xs"
          variant size: :sm, class: "loading-sm"
          variant size: :md, class: "loading-md"
          variant size: :lg, class: "loading-lg"
          variant size: :xl, class: "loading-xl"

          variant style: :ball, class: "loading-ball"
          variant style: :bars, class: "loading-bars"
          variant style: :dots, class: "loading-dots"
          variant style: :infinity, class: "loading-infinity"
          variant style: :ring, class: "loading-ring"
          variant style: :spinner, class: "loading-spinner"
        end

      attr_reader :size
      attr_reader :style

      def initialize(class: "", size: nil, style: :spinner, **extra_attributes)
        @extra_attributes = extra_attributes
        @extra_classes = binding.local_variable_get(:class)
        @size = size
        @style = style
      end

      def view_template
        span(class: "#{VARIANT.render(size:, style:)} #{@extra_classes}".strip, **@extra_attributes)
      end
    end
  end
end
