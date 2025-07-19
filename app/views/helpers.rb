# auto_register: false
# frozen_string_literal: true

module Pennywise
  module Views
    module Helpers
      def flash_alert_class(flash_type)
        case flash_type.to_sym
        when :error
          "alert-error"
        when :success
          "alert-success"
        when :info
          "alert-info"
        when :warn, :warning
          "alert-warning"
        else
          ""
        end
      end
    end
  end
end
