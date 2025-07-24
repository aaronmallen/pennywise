# frozen_string_literal: true

require "dry/core/equalizer"
require "dry/configurable"
require "dry/inflector"
require "forwardable"

module UI
  class View < Component
    extend Dry::Configurable
    extend Forwardable

    include Dry.Equalizer(:config)

    setting :inflector, default: Dry::Inflector.new
    setting :layout, default: "app"
    setting :page_title

    def_delegators :context, :asset_url, :csrf_token, :flash, :inflector, :routes, :session

    attr_reader :context

    def initialize(context, **kwargs)
      super()

      self.class.config.finalize!
      @context = context
      kwargs.each_pair { |k, v| instance_variable_set("@#{k}", v) }
    end

    def config
      self.class.config
    end

    protected

    def render_partial(partial_class)
      partial_class =
        if partial_class.is_a?(String)
          parent = inflector.constantize(self.class.name.split("::")[0..-2].join("::"))
          const = inflector.classify(partial_class)
          parent.const_get(const) if parent.const_defined?(const)
        else
          partial_class
        end

      kwargs =
        instance_variables.each_with_object({}) do |var, hash|
          hash[var.to_s.delete("@").to_sym] = instance_variable_get(var)
        end

      partial_class.new(context, **kwargs).view_template
    end
  end
end
