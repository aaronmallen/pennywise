# frozen_string_literal: true

module Pennywise
  module Views
    module Sessions
      class New < View
        config.layout = :auth

        def view_template
          Card(class: "w-full max-w-md bg-white shadow-xl") do |card|
            card.with_title(class: "p-8 space-y-6 block") do
              div class: "text-center space-y-3" do
                h1(class: "text-3xl font-bold text-slate-800") { "Welcome Back!" }
                p(class: "text-slate-600 text-base font-normal") { "Sign in to continue managing your finances" }
              end
            end

            card.with_body(class: "p-8 space-y-6") do
              form(action: routes.path(:sign_in), class: "space-y-5", method: "post", novalidate: true, role: "form") do
                method_field
                csrf_field
                email_field
                password_field
                remember_me_field
                submit_button
              end
            end
          end
        end

        private

        def csrf_field
          input(id: "_csrf_token", name: "_csrf_token", type: "hidden", value: csrf_token)
        end

        def email_field
          div do
            label(
              for: "session[email]",
              class:
                "input input-bordered flex w-full items-center gap-2 focus-within:ring-2 " \
                  "focus-within:ring-slate-200 focus-within:border-slate-400 transition-all duration-200",
            ) do
              Icon(:envelope, regular: true, class: "text-base-content/40", aria_hidden: true)
              input(
                aria_label: "Email Address",
                autocomplete: "email",
                class: "grow bg-transparent outline-none",
                id: "session[email]",
                name: "session[email]",
                placeholder: "Email Address",
                required: true,
                tabindex: 1,
                type: :email,
              )
            end
          end
        end

        def method_field
          input(id: "_method", name: "_method", type: "hidden", value: "post")
        end

        def password_field
          div do
            label(
              for: "session[password]",
              class:
                "input input-bordered flex w-full items-center gap-2 focus-within:ring-2 " \
                  "focus-within:ring-slate-200 focus-within:border-slate-400 transition-all duration-200",
            ) do
              Icon(:lock, regular: true, class: "text-base-content/40", aria_hidden: true)
              input(
                aria_label: "Password",
                autocomplete: "current-password",
                class: "grow bg-transparent outline-none",
                id: "session[password]",
                name: "session[password]",
                placeholder: "Password",
                required: true,
                tabindex: 2,
                type: :password,
              )
            end
          end
        end

        def remember_me_field
          div class: "flex items-center justify-between" do
            div class: "label-text flex-1" do
              "Remember me"
            end
            input(
              aria_label: "Remember me for longer",
              class: "toggle toggle-primary ml-3",
              id: "session[remember]",
              name: "session[remember]",
              tabindex: 3,
              type: :checkbox,
            )
          end
        end

        def submit_button
          Button(
            aria_label: "Sign in to your account",
            class: "w-full text-white font-semibold shadow-lg",
            color: :primary,
            size: :lg,
            tabindex: 4,
            type: :submit,
          ) { "Sign In" }
        end
      end
    end
  end
end
