# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Repos::SessionRepo do
  subject(:repo) { app["repos.session_repo"] }

  let(:crypto_service) { app["services.crypto_service"] }
  let(:sessions) { app["relations.sessions"] }

  describe "#by_pk" do
    subject(:by_pk) { repo.by_pk(id) }

    context "when a session with a matching id exists" do
      let(:id) { Factory.create(:session).id }

      it "returns a Pennywise::Structs::Session" do
        expect(by_pk).to be_a(Pennywise::Structs::Session).and(have_attributes(id:))
      end
    end

    context "when a session with a matching id does not exist" do
      let(:id) { Faker::Internet.uuid }

      it { expect(by_pk).to be_nil }
    end
  end

  describe "#by_token" do
    subject(:by_token) { repo.by_token(token) }

    context "when a session with a matching token exists" do
      let(:token) { crypto_service.generate_secret }
      let!(:session) { Factory.create(:session, token_digest: crypto_service.generate_sha_digest(token)) }

      it "returns a Pennywise::Structs::Session" do
        expect(by_token).to be_a(Pennywise::Structs::Session).and(have_attributes(id: session.id))
      end
    end

    context "when a session with a matching token does not exist" do
      let(:token) { Faker::Crypto.sha256 }

      it { expect(by_token).to be_nil }
    end
  end

  describe "#create" do
    subject(:create) { repo.create(attributes) }

    let(:attributes) { { identity_id: Factory.create(:identity).id, token_digest: Faker::Crypto.sha256 } }

    it { expect { create }.to change(sessions, :count).by(1) }
  end
end
