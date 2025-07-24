# frozen_string_literal: true

module Pennywise
  module Layouts
    class App
      class Sidebar < UI::View::Partial
        def view_template
          mobile_overlay

          aside(
            id: "sidebar",
            class:
              "fixed lg:sticky flex flex-col h-screen overflow-hidden bg-base-200 flex-shrink-0 transition-all " \
                "duration-300 z-50 lg:translate-x-0 -translate-x-full",
          ) do
            main_nav
            user_nav
          end

          script type: "text/javascript", src: asset_url("sidebar/app.js")
        end

        private

        def brand
          div id: "sidebar-brand", class: "flex flex-row items-center mb-4" do
            h1(class: "sidebar-text flex-1 text-xl font-semibold") { "Pennywise" }
            button id: "sidebar-toggle", class: "cursor-pointer pr-2 hidden lg:block" do
              Icon("arrow-left-from-line", class: "text-base-content/30 transition-transform duration-300", size: :xl)
            end
            button id: "mobile-close", class: "cursor-pointer pr-2 lg:hidden" do
              Icon("times", solid: true, size: :xl, class: "text-base-content/30")
            end
          end
        end

        def main_nav
          div class: "pl-4 pr-0 pt-4 pb-4 flex-1" do
            brand
            nav_container do
              menu_item(
                href: routes.path(:root),
                icon: "envelope-open-dollar",
                label: "Budget",
                active: context.request.fullpath == routes.path(:root),
              )
            end
          end
        end

        def menu_item(href:, icon:, label:, active: nil)
          active = context.request.fullpath.start_with?(href) if active.nil?

          li(
            class:
              "hover:bg-base-100 hover:border-r-0 rounded-l-lg transition-colors duration-200 pr-4 " \
                "#{"bg-base-100 border-r-0" if active}".strip,
          ) do
            a(class: "flex items-center px-4 py-3 font-medium text-base-content no-underline", href: href) do
              Icon(icon, class: "text-base-content/70 w-5 text-center flex-shrink-0", regular: true, size: :xl)
              span(class: "sidebar-text px-4") { label }
            end
          end
        end

        def mobile_overlay
          button id: "mobile-menu-toggle", class: "fixed top-0 left-4 z-50 lg:hidden btn btn-ghost btn-circle" do
            Icon(:bars, class: "text-xl")
          end
          div id: "mobile-overlay", class: "fixed inset-0 bg-black/50 z-40 lg:hidden hidden"
        end

        def nav_container(&)
          nav { ul(class: "space-y-1", &) }
        end

        def user_nav
          div class: "border-t border-base-300 pl-4 pr-0 pt-4 pb-4" do
            nav_container { menu_item(href: routes.path(:sign_out), icon: "right-from-bracket", label: "Sign Out") }
          end
        end
      end
    end
  end
end
