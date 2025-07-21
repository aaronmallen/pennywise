# frozen_string_literal: true

module UI
  class View
    class Layout < View
      def initialize(view_class, context, **)
        @page_title = [self.class.config.page_title, view_class.config.page_title].compact.join(" | ")
        @view = view_class.new(context, **)

        super(context, **)
      end

      def view_template
        doctype
        html lang: "en" do
          head { title { @page_title } }
          body { render_view }
        end
      end

      protected

      def render_view
        render @view
      end
    end
  end
end
