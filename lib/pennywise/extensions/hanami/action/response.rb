# frozen_string_literal: true

require "ui"

module Pennywise
  module Extensions
    module Hanami
      module Action
        module Response
          def render(view_class, **)
            context = build_context
            layout_class = resolve_layout_class(view_class)
            self.body = layout_class.new(view_class, context, **).call
          end

          private

          def build_context
            UI::View::Context.new(
              assets: slice["assets"],
              inflector: slice["inflector"],
              request:,
              response: self,
              routes: slice["routes"],
              settings: slice["settings"],
            )
          end

          def resolve_layout_class(view_class)
            return Pennywise::Layout unless view_class.config.layout

            layout_class_name = "Layouts::#{slice["inflector"].classify(view_class.config.layout)}"
            return slice.namespace.const_get(layout_class_name) if slice.namespace.const_defined?(layout_class_name)

            Pennywise::Layout
          end

          def slice
            @slice ||=
              begin
                action_instance = env["hanami.action_instance"]
                if action_instance.nil?
                  ::Hanami.app
                else
                  action_instance
                    .routes
                    .instance_variable_get(:@router)
                    .instance_variable_get(:@resolver)
                    .instance_variable_get(:@slice)
                end
              end
          end
        end
      end
    end
  end
end

Hanami::Action::Response.prepend(Pennywise::Extensions::Hanami::Action::Response)
