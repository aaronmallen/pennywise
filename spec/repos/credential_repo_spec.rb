# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Repos::CredentialRepo do
  subject(:repo) { app["repos.credential_repo"] }

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
end
