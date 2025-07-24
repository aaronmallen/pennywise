# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Layouts::Shared::Head do
  describe "#call" do
    subject(:call) { described_class.new(mock_context).call }

    before { allow(mock_context).to receive(:asset_url).with("app.css").and_return("assets/css/app.css") }

    let(:mock_context) { instance_double(UI::View::Context) }

    it "includes the app stylesheet" do
      expect(call).to include("<link rel=\"stylesheet\" href=\"assets/css/app.css\">")
    end

    context "when the layout has a page title" do
      let(:layout) do
        Class.new(UI::View::Layout) do
          config.page_title = "Test Page"

          def view_template
            render_partial Pennywise::Layouts::Shared::Head
          end
        end
      end

      it "renders the page title" do
        expect(layout.new(UI::View, mock_context).call).to include("<title>Test Page</title>")
      end
    end
  end
end
