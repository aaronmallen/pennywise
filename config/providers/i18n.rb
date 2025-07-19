# frozen_string_literal: true

Hanami.app.register_provider :i18n, namespace: true do
  prepare { require "i18n" }

  start do
    I18n.load_path += Dir[target.root.join("config/locales/**/*.yml")]
    I18n.backend.load_translations

    register :t, I18n.method(:t)
  end
end
