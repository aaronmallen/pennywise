# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Contracts::NewSessionContract do
  subject(:contract) { app["contracts.new_session_contract"] }

  describe "#call" do
    subject(:call) { contract.call(params) }

    context "when given valid params" do
      let(:params) do
        { session: { email: Faker::Internet.email, password: Faker::Internet.password(min_length: 8), remember: true } }
      end

      it { is_expected.to be_success }
    end

    context "when given an invalid email address" do
      let(:params) do
        {
          session: {
            email: Faker::Internet.username,
            password: Faker::Internet.password(min_length: 8),
            remember: true,
          },
        }
      end

      it { is_expected.to be_failure }

      it "returns an error message" do
        expect(call.errors.to_h).to eq(session: { email: ["is not a valid email address"] })
      end
    end

    context "when given a :password that is less than 8 characters" do
      let(:params) do
        {
          session: {
            email: Faker::Internet.email,
            password: Faker::Internet.password(min_length: 2, max_length: 7),
            remember: true,
          },
        }
      end

      it { is_expected.to be_failure }

      it "returns an error message" do
        expect(call.errors.to_h).to eq(session: { password: ["must be at least 8 characters"] })
      end
    end
  end
end
