# frozen_string_literal: true

require "ui"

module Pennywise
  module Extensions
    module Hanami
      module SliceConfiguredAction
        def resolve_paired_view(action_class)
          view_identifiers = actions_config.view_name_inferrer.call(action_class_name: action_class.name, slice: slice)

          view_identifiers.each do |identifier|
            next unless slice.key?(identifier)

            view_const_name = slice.app.inflector.classify(identifier.tr(".", "/"))
            next unless slice.namespace.const_defined?(view_const_name)

            return slice.namespace.const_get(view_const_name)
          end

          nil
        end
      end
    end
  end
end

Hanami::Action::SliceConfiguredAction.prepend(Pennywise::Extensions::Hanami::SliceConfiguredAction)
