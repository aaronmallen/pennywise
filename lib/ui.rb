# frozen_string_literal: true

require "zeitwerk"

module UI
  class << self
    def setup_loader
      root_path = File.dirname(__FILE__)

      loader =
        Zeitwerk::Loader.new.tap do |loader|
          loader.tag = "ui"
          loader.enable_reloading

          loader.push_dir(File.join(root_path, "ui"), namespace: UI)
        end

      loader.setup
      loader.eager_load_dir(File.join(root_path, "ui/components"))
    end
  end
end

UI.setup_loader
