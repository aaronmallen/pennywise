# auto_register: false
# frozen_string_literal: true

require "hanami/view"

module Pennywise
  class View < Hanami::View
    expose(:page_title, layout: true) { nil }
  end
end
