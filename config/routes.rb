# frozen_string_literal: true

module Pennywise
  class Routes < Hanami::Routes
    get "/sign-in", to: "sessions.new", as: :sign_in
    post "/sign-in", to: "sessions.create", as: :create_session
    get "/sign-out", to: "sessions.destroy", as: :sign_out

    root to: "budgets.index"
  end
end
