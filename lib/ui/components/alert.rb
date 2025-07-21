# frozen_string_literal: true

module UI
  module Components
    class Alert < Component
      VARIANT =
        ClassVariants.build do
          base "alert"

          variant dash: true, class: "alert-dash"
          variant outline: true, class: "alert-outline"
          variant soft: true, class: "alert-soft"

          variant type: :error, class: "alert-error"
          variant type: :info, class: "alert-info"
          variant type: :success, class: "alert-success"
          variant type: :warning, class: "alert-warning"
        end

      attr_reader :dash
      attr_reader :outline
      attr_reader :soft
      attr_reader :type

      def initialize(class: "", dash: false, outline: false, soft: false, type: nil, **extra_attributes)
        @dash = dash
        @extra_attributes = extra_attributes
        @extra_classes = binding.local_variable_get(:class)
        @outline = outline
        @soft = soft
        @type = type
      end

      def view_template
        div(
          class: "#{VARIANT.render(dash:, outline:, soft:, type:)} #{@extra_classes}".strip,
          role: "alert",
          **@extra_attributes,
        ) do
          Icon(icon_class) if icon_class
          yield if block_given?
          dismiss_button
        end
      end

      private

      def icon_class
        case type
        when :error, :warn, :warning
          "exclamation-triangle"
        when :success
          :check
        when :info
          "info-circle"
        end
      end

      def dismiss_button
        button(
          type: "button",
          class:
            "flash-dismiss flex-shrink-0 cursor-pointer w-6 h-6 flex items-center justify-center rounded-full " \
              "hover:bg-white/20 transition-colors duration-200 ml-4",
          aria_label: "Dismiss Notification",
        ) { Icon(:xmark, thin: true, class: "text-sm", aria_hidden: true) }
      end
    end
  end
end
