# frozen_string_literal: true

require "spec_helper"

RSpec.describe UI::Components::Alert do
  describe "#call" do
    subject(:call) { described_class.new(**params, &block).call }

    let(:params) { {} }
    let(:block) { proc { "Test Alert" } }

    it "renders the alert" do
      expect(call).to eq(<<~HTML.gsub(/\n\s*/, "").strip)
        <div class="alert" role="alert">
          Test Alert
          <button 
            type="button" 
            class="flash-dismiss flex-shrink-0 cursor-pointer w-6 h-6 flex items-center justify-center rounded-full hover:bg-white/20 transition-colors duration-200 ml-4" 
            aria-label="Dismiss Notification"
          >
            <i class="fa-sharp fa-thin fa-xmark text-sm" aria-hidden></i>
          </button>
        </div>
      HTML
    end

    context "when using the dash variant" do
      let(:params) { { dash: true } }

      it "adds the alert-dash class" do
        expect(call).to include("alert alert-dash")
      end
    end

    context "when using the outline variant" do
      let(:params) { { outline: true } }

      it "adds the alert-outline class" do
        expect(call).to include("alert alert-outline")
      end
    end

    context "when using the soft variant" do
      let(:params) { { soft: true } }

      it "adds the alert-soft class" do
        expect(call).to include("alert alert-soft")
      end
    end

    context "when using the error type variant" do
      let(:params) { { type: :error } }

      it "adds the alert-error class" do
        expect(call).to include("alert alert-error")
      end

      it "adds the error icon" do
        expect(call).to include("<i class=\"fa-sharp fa-exclamation-triangle\"></i>")
      end
    end

    context "when using the info type variant" do
      let(:params) { { type: :info } }

      it "adds the alert-info class" do
        expect(call).to include("alert alert-info")
      end

      it "adds the info icon" do
        expect(call).to include("<i class=\"fa-sharp fa-info-circle\"></i>")
      end
    end

    context "when using the success type variant" do
      let(:params) { { type: :success } }

      it "adds the alert-success class" do
        expect(call).to include("alert alert-success")
      end

      it "adds the success icon" do
        expect(call).to include("<i class=\"fa-sharp fa-check\"></i>")
      end
    end

    context "when using the warning type variant" do
      let(:params) { { type: :warning } }

      it "adds the alert-warning class" do
        expect(call).to include("alert alert-warning")
      end

      it "adds the warning icon" do
        expect(call).to include("<i class=\"fa-sharp fa-exclamation-triangle\"></i>")
      end
    end

    context "when passing a custom class" do
      let(:params) { { class: "text-sm" } }

      it "renders the alert" do
        expect(call).to include("<div class=\"alert text-sm\" role=\"alert\">")
      end
    end

    context "when passing custom attributes" do
      let(:params) { { aria_label: "alert" } }

      it "renders the alert" do
        expect(call).to include("<div class=\"alert\" role=\"alert\" aria-label=\"alert\">")
      end
    end
  end
end
