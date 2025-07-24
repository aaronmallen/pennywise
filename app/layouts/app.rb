# frozen_string_literal: true

module Pennywise
  module Layouts
    class App < Layout
      def view_template
        doctype
        html do
          render_partial "shared/head"
          body class: "min-h-screen bg-base-200" do
            div class: "flex flex-row" do
              render_partial "app/sidebar"
              div class: "flex-1" do
                div class: "my-2 mr-2 bg-base-100 rounded-lg min-h-[calc(100vh-1rem)]" do
                  main class: "p-8" do
                    render_view
                  end
                end
              end
            end
            render_partial "shared/flash_message"
            script type: "text/javascript", src: asset_url("app.js")
          end
        end
      end
    end
  end
end
