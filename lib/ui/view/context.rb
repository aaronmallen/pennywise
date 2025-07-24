# frozen_string_literal: true

module UI
  class View
    class Context
      attr_reader :assets
      attr_reader :inflector
      attr_reader :request
      attr_reader :response
      attr_reader :routes
      attr_reader :settings

      def initialize(assets: nil, inflector: nil, request: nil, response: nil, routes: nil, settings: nil)
        @assets = assets
        @inflector = inflector
        @request = request
        @response = response
        @routes = routes
        @settings = settings
      end

      def asset_url(path)
        assets[path].url
      end

      def csrf_token
        session[Hanami::Action::CSRFProtection::CSRF_TOKEN]
      end

      def flash
        response.flash
      end

      def session
        request.session
      end
    end
  end
end
