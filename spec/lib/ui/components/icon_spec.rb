# frozen_string_literal: true

require "spec_helper"

RSpec.describe UI::Components::Icon do
  describe "#call" do
    subject(:call) { described_class.new(icon, **params).call }

    let(:icon) { :check }
    let(:params) { {} }

    it "renders the icon" do
      expect(call).to eq("<i class=\"fa-sharp fa-check\"></i>")
    end

    context "when using the light variant" do
      let(:params) { { light: true } }

      it "has the fa-light class" do
        expect(call).to include("fa-light")
      end
    end

    context "when using the regular variant" do
      let(:params) { { regular: true } }

      it "has the fa-regular class" do
        expect(call).to include("fa-regular")
      end
    end

    context "when using the solid variant" do
      let(:params) { { solid: true } }

      it "has the fa-solid class" do
        expect(call).to include("fa-solid")
      end
    end

    context "when using the thin variant" do
      let(:params) { { thin: true } }

      it "has the fa-thin class" do
        expect(call).to include("fa-thin")
      end
    end

    context "when using the xxs size variant" do
      let(:params) { { size: :xxs } }

      it "has the fa-2xs class" do
        expect(call).to include("fa-2xs")
      end
    end

    context "when using the xs size variant" do
      let(:params) { { size: :xs } }

      it "has the fa-xs class" do
        expect(call).to include("fa-xs")
      end
    end

    context "when using the sm size variant" do
      let(:params) { { size: :sm } }

      it "has the fa-sm class" do
        expect(call).to include("fa-sm")
      end
    end

    context "when using the lg size variant" do
      let(:params) { { size: :lg } }

      it "has the fa-lg class" do
        expect(call).to include("fa-lg")
      end
    end

    context "when using the xl size variant" do
      let(:params) { { size: :xl } }

      it "has the fa-xl class" do
        expect(call).to include("fa-xl")
      end
    end

    context "when using the xxl size variant" do
      let(:params) { { size: :xxl } }

      it "has the fa-2xl class" do
        expect(call).to include("fa-2xl")
      end
    end

    context "when passing a custom class" do
      let(:params) { { class: "text-sm" } }

      it "renders the icon" do
        expect(call).to eq("<i class=\"fa-sharp fa-check text-sm\"></i>")
      end
    end

    context "when passing custom attributes" do
      let(:params) { { aria_label: "icon" } }

      it "renders the icon" do
        expect(call).to eq("<i class=\"fa-sharp fa-check\" aria-label=\"icon\"></i>")
      end
    end
  end
end
