# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Structs::Identity do
  describe "#active?" do
    subject(:active?) { struct.active? }

    context "when the Identity has a status of 'active'" do
      let(:struct) { Factory.build(:identity, :active) }

      it { is_expected.to be true }
    end

    Pennywise::Types::IdentityStatus.each_value do |status|
      next if Pennywise::Types::IdentityStatus["active"] == status

      context "when the Identity has a status of '#{status}'" do
        let(:struct) { Factory.build(:identity, status: status) }

        it { is_expected.to be false }
      end
    end
  end
end
