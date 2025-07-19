# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Services::Crypto::PasswordService do
  subject(:service) { app["services.crypto.password_service"] }

  describe "#generate_digest" do
    subject(:generate_digest) { service.generate_digest(plaintext) }

    let(:plaintext) { Faker::Internet.password(min_length: 8) }

    it "generates an Argon2 digest" do
      expect(generate_digest).to match(/^\$argon2/)
    end
  end

  describe "#verify" do
    subject(:verify) { service.verify(plaintext, digest) }

    let(:plaintext) { Faker::Internet.password(min_length: 8) }

    context "when the plaintext matches the digest" do
      let(:digest) { service.generate_digest(plaintext) }

      it { is_expected.to be true }
    end

    context "when the plaintext does not match the digest" do
      let(:digest) { service.generate_digest("#{plaintext}aaa") }

      it { is_expected.to be false }
    end
  end
end
