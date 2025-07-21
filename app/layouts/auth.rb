# frozen_string_literal: true

module Pennywise
  module Layouts
    class Auth < Layout
      def view_template
        doctype
        html do
          render_partial "shared/head"
          body class: "flex flex-col h-screen w-screen items-center justify-center bg-base-200" do
            render_view
            render_partial "shared/flash_message"
            script type: "text/javascript", src: asset_url("app.js")
          end
        end
      end
    end
  end
end
