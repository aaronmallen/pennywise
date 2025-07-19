# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Services::Crypto::HashingService do
  subject(:service) { app["services.crypto.hashing_service"] }

  describe "#generate_sha" do
    subject(:generate_sha) { service.generate_sha(plaintext) }

    let(:plaintext) { Faker::Lorem.word }

    it { is_expected.to be_a(String).and(have_attributes(length: 64)) }
  end

  describe "#verify_sha" do
    subject(:verify_sha) { service.verify_sha(plaintext, digest) }

    let(:plaintext) { Faker::Lorem.word }

    context "when the digest matches" do
      let(:digest) { service.generate_sha(plaintext) }

      it { is_expected.to be true }
    end

    context "when the digest does not match" do
      let(:digest) { service.generate_sha("#{plaintext}aaa") }

      it { is_expected.to be false }
    end
  end
end
