# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Operations::AuthenticateIdentity do
  subject(:operation) { app["operations.authenticate_identity"] }

  let(:credential_repo) { app["repos.credential_repo"] }
  let(:crypto_service) { app["services.crypto_service"] }

  describe "#call" do
    subject(:call) { operation.call(params) }

    context "when given valid params" do
      let(:password) { Faker::Internet.password(min_length: 8) }

      let(:credential) do
        digest = crypto_service.generate_password_digest(password)
        Factory.create(:credential, digest:)
      end

      let(:params) { { session: { email: credential.email, password:, remember: true } } }

      it { is_expected.to be_success }

      it "returns the identity" do
        expect(call.value!).to be_a(Pennywise::Structs::Identity).and(have_attributes(id: credential.identity_id))
      end

      context "when the credential is locked" do
        let(:credential) do
          digest = crypto_service.generate_password_digest(password)
          Factory.create(:credential, :locked, digest:)
        end

        it { is_expected.to be_failure }

        it "returns an error message" do
          expect(call.failure).to match(
            /Too many failed sign-in attempts. Your account has been temporarily locked for security/,
          )
        end
      end
    end

    context "when no credential with a matching email exists" do
      let(:params) do
        { session: { email: Faker::Internet.email, password: Faker::Internet.password(min_length: 8), remember: true } }
      end

      it { is_expected.to be_failure }

      it "returns an error message" do
        expect(call.failure).to eq("Something went wrong. If the problem persists please contact your admin.")
      end
    end

    context "when given an invalid password" do
      let(:credential) { Factory.create(:credential) }

      let(:params) do
        { session: { email: credential.email, password: Faker::Internet.password(min_length: 8), remember: true } }
      end

      it { is_expected.to be_failure }

      it "returns an error message" do
        expect(call.failure).to eq("Something went wrong. If the problem persists please contact your admin.")
      end

      context "when the credential has between two and three previous failed attempts" do
        let(:credential) { Factory.create(:credential, failed_attempts: rand(2..3)) }

        it "locks the credential for 5 minutes" do
          call
          from_db = credential_repo.by_pk(credential.identity_id)

          expect(from_db).to be_locked.and(have_attributes(locked_until: be_within(5).of(Time.now.utc + 300)))
        end

        it "returns an error message" do
          expect(call.failure).to eq(
            "Too many failed sign-in attempts. Your account has been temporarily locked for security. " \
              "Please try again in 5 minutes.",
          )
        end
      end

      context "when the credential has between four and eight previous failed attempts" do
        let(:credential) { Factory.create(:credential, failed_attempts: rand(4..8)) }

        it "locks the credential for 30 minutes" do
          call
          from_db = credential_repo.by_pk(credential.identity_id)

          expect(from_db).to be_locked.and(have_attributes(locked_until: be_within(5).of(Time.now.utc + 1800)))
        end

        it "returns an error message" do
          expect(call.failure).to eq(
            "Too many failed sign-in attempts. Your account has been temporarily locked for security. " \
              "Please try again in 30 minutes.",
          )
        end
      end

      context "when the credential has between nine and eighteen previous failed attempts" do
        let(:credential) { Factory.create(:credential, failed_attempts: rand(9..18)) }

        it "locks the credential for 2 hours" do
          call
          from_db = credential_repo.by_pk(credential.identity_id)

          expect(from_db).to be_locked.and(have_attributes(locked_until: be_within(5).of(Time.now.utc + 7200)))
        end

        it "returns an error message" do
          expect(call.failure).to eq(
            "Too many failed sign-in attempts. Your account has been temporarily locked for security. " \
              "Please try again in 2 hours.",
          )
        end
      end

      context "when the credential has nineteen or more previous failed attempts" do
        let(:credential) { Factory.create(:credential, failed_attempts: 19) }

        it "locks the credential for 24 hours" do
          call
          from_db = credential_repo.by_pk(credential.identity_id)

          expect(from_db).to be_locked.and(have_attributes(locked_until: be_within(5).of(Time.now.utc + 86_400)))
        end

        it "returns an error message" do
          expect(call.failure).to eq(
            "Too many failed sign-in attempts. Your account has been temporarily locked for security. " \
              "Please try again in 24 hours.",
          )
        end
      end
    end

    context "when given invalid params" do
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
        expect(call.failure).to be_a(Hash)
      end
    end
  end
end
