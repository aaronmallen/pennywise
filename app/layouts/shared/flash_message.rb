# frozen_string_literal: true

module Pennywise
  module Layouts
    module Shared
      class FlashMessage < UI::View::Partial
        def view_template
          div(
            id: "flash-container",
            class: "fixed bottom-6 left-1/2 transform -translate-x-1/2 z-50 space-y-3 max-w-2xl w-full px-4",
          ) do
            flash.each do |type, message|
              next if message.nil? || message.empty?

              Alert(
                type:,
                class: "flash-message shadow-lg opacity-0 translate-y-4 transition-all duration-300 ease-out",
                data_flash_type: type,
                aria_live: "polite",
              ) { span(class: "text-sm font-medium") { message } }
            end
          end
        end
      end
    end
  end
end
