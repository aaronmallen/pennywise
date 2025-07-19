# frozen_string_literal: true

module Pennywise
  module Actions
    module Sessions
      class Destroy < Action::Protected
        include Deps["repos.session_repo"]

        def handle(request, response)
          session_repo.revoke_by_token(request.session[:token])
          response.session[:token] = nil
          response.redirect_to routes.path(:sign_in)
        end
      end
    end
  end
end
