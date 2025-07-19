# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Structs::Profile do
  describe "#full_name" do
    subject(:full_name) { struct.full_name }

    let(:struct) { Factory.build(:profile) }

    it { is_expected.to eq("#{struct.first_name} #{struct.last_name}") }
  end
end
