# frozen_string_literal: true

module Pennywise
  class Routes < Hanami::Routes
    get "/sign-in", to: "sessions.new", as: :sign_in
    post "/sign-in", to: "sessions.create", as: :create_session

    root to: "budgets.index"
  end
end
