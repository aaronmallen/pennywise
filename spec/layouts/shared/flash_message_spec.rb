# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Layouts::Shared::FlashMessage do
  describe "#call" do
    subject(:call) { described_class.new(mock_context).call }

    let(:mock_context) { instance_double(UI::View::Context, flash: mock_flash) }
    let(:mock_flash) { {} }

    it "renders the flash container" do
      expect(call).to include("<div id=\"flash-container\"")
    end

    context "when the flash has messages" do
      let(:mock_flash) { { success: "Success!" } }

      it "renders the appropriate alert class" do
        expect(call).to include("alert alert-success")
      end

      it "renders the flash message" do
        expect(call).to include("Success!")
      end
    end
  end
end
