# frozen_string_literal: true

RSpec.shared_context "with app" do
  let(:app) { Hanami.app }
end

RSpec.configure { |config| config.include_context "with app" }
