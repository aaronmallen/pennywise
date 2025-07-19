# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Structs::Session do
  describe "#expired?" do
    subject(:expired?) { struct.expired? }

    context "when the session is expired" do
      let(:struct) { Factory.build(:session, :expired) }

      it { is_expected.to be true }
    end

    context "when the session is not expired" do
      let(:struct) { Factory.build(:session) }

      it { is_expected.to be false }
    end
  end

  describe "#revoked?" do
    subject(:revoked?) { struct.revoked? }

    context "when the session is revoked" do
      let(:struct) { Factory.build(:session, :revoked) }

      it { is_expected.to be true }
    end

    context "when the session is not revoked" do
      let(:struct) { Factory.build(:session) }

      it { is_expected.to be false }
    end
  end
end
