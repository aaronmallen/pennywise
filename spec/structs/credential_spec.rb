# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Structs::Credential do
  describe "#locked?" do
    subject(:locked?) { struct.locked? }

    context "when the Credential is locked" do
      let(:struct) { Factory.build(:credential, :locked) }

      it { is_expected.to be true }
    end

    context "when the Credential is not locked" do
      let(:struct) { Factory.build(:credential) }

      it { is_expected.to be false }
    end
  end
end
