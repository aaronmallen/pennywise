# frozen_string_literal: true

RSpec.describe Pennywise::Actions::Sessions::New do
  subject(:action) { app["actions.sessions.new"] }

  describe "#call" do
    subject(:call) { action.call(params) }

    let(:params) { {} }

    it { is_expected.to be_successful }
  end
end
