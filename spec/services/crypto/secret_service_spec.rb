# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Services::Crypto::SecretService do
  subject(:service) { app["services.crypto.secret_service"] }

  describe "#generate" do
    subject(:generate) { service.generate }

    it { is_expected.to be_a(String).and(have_attributes(length: described_class::DEFAULT_SECRET_BYTES * 2)) }
  end
end
