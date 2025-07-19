# frozen_string_literal: true

module Pennywise
  class Action
    module AuthHelpers
      class << self
        private

        def included(action)
          super

          action.include Deps["repos.identity_repo", "repos.session_repo"]
        end
      end

      protected

      def authorize_user!(request, response)
        if (token = request.session[:token])
          session = session_repo.touch_by_token(token)
          request.env[:current_user] = identity_repo.by_pk(session.identity_id) if session
        end

        response.redirect_to routes.path("/sign-in") unless request.env[:current_user]
      end
    end
  end
end
