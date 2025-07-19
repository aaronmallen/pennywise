# frozen_string_literal: true

module Pennywise
  class Action
    class Protected < Action
      before :authorize_user!
    end
  end
end
