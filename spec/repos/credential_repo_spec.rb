# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Repos::CredentialRepo do
  subject(:repo) { app["repos.credential_repo"] }

  describe "#by_email" do
    subject(:by_email) { repo.by_email(email) }

    context "when a credential with a matching email exists" do
      let(:email) { Factory.create(:credential).email }

      it "returns a Pennywise::Structs::Credential" do
        expect(by_email).to be_a(Pennywise::Structs::Credential).and(have_attributes(email:))
      end
    end

    context "when a credential with a matching email does not exist" do
      let(:email) { Faker::Internet.email }

      it { is_expected.to be_nil }
    end
  end

  describe "#by_pk" do
    subject(:by_pk) { repo.by_pk(identity_id) }

    context "when a credential with a matching identity_id exists" do
      let(:identity_id) { Factory.create(:credential).identity_id }

      it "returns a Pennywise::Structs::Credential" do
        expect(by_pk).to be_a(Pennywise::Structs::Credential).and(have_attributes(identity_id:))
      end
    end

    context "when a credential with a matching identity_id does not exist" do
      let(:identity_id) { Faker::Internet.uuid }

      it { expect(by_pk).to be_nil }
    end
  end

  describe "#mark_sign_in_failure" do
    subject(:mark_sign_in_failure) { repo.mark_sign_in_failure(identity_id) }

    let(:credential) { Factory.create(:credential) }
    let(:identity_id) { credential.identity_id }

    it "updates the credential's failed_attempts" do
      mark_sign_in_failure
      from_db = repo.by_pk(identity_id)

      expect(from_db).to have_attributes(failed_attempts: credential.failed_attempts + 1)
    end
  end

  describe "#mark_sign_in_success" do
    subject(:mark_sign_in_success) { repo.mark_sign_in_success(identity_id) }

    let(:credential) { Factory.create(:credential, :locked) }
    let(:identity_id) { credential.identity_id }

    it "updates the credential's failed_attempts to 0" do
      mark_sign_in_success
      from_db = repo.by_pk(identity_id)

      expect(from_db).to have_attributes(failed_attempts: 0, locked_until: nil)
    end
  end

  describe "#lock" do
    subject(:lock) { repo.lock(identity_id, lock_until) }

    let(:credential) { Factory.create(:credential) }
    let(:identity_id) { credential.identity_id }
    let(:lock_until) { Time.now.utc + (60 * 5) }

    it "updates the credential's locked_until" do
      lock
      from_db = repo.by_pk(identity_id)

      expect(from_db).to have_attributes(locked_until: be_within(5).of(lock_until))
    end
  end
end
