# frozen_string_literal: true

module Pennywise
  module Actions
    module Sessions
      class Create < Action
        include Deps["i18n.t", "operations.authenticate_identity", "operations.create_session"]

        params Contracts::NewSessionContract

        def handle(request, response)
          case authenticate_identity.call(request.params.to_h)
          in Success[identity]
            handle_successful_authentication(identity, request, response)
          in Failure[String => error]
            response.status = :unprocessable_entity
            response.flash.now[:error] = error
          in Failure[Hash => errors]
            response.status = :unprocessable_entity
            response.render(view, errors:)
          end
        end

        private

        def handle_successful_authentication(identity, request, response)
          case create_session.call(identity, request, remember: request.params[:remember])
          in Success[token]
            response.session[:token] = token
            response.flash.next[:success] = "Welcome back!"
            response.redirect_to routes.path(:root)
          else
            response.status = :unprocessable_entity
            response.flash.now[:error] = t.call("pennywise.generic_authentication_error")
          end
        end
      end
    end
  end
end
