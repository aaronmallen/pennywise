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

  describe "#revoke_by_token" do
    subject(:revoke_by_token) { repo.revoke_by_token(token) }

    let(:token) { crypto_service.generate_secret }
    let!(:session) do
      Factory.create(
        :session,
        token_digest: crypto_service.generate_sha_digest(token),
        last_activity_at: Time.now.utc - 60,
      )
    end

    it "revokes the session" do
      revoke_by_token
      from_db = repo.by_token(token)

      expect(from_db).to be_revoked
    end

    it "updates the session's last_activity_at" do
      revoke_by_token
      from_db = repo.by_token(token)

      expect(from_db.last_activity_at).to be > session.last_activity_at
    end

    context "when the session was previously revoked" do
      let!(:session) { Factory.create(:session, :revoked, token_digest: crypto_service.generate_sha_digest(token)) }

      it "does not update the session's revoked_at date" do
        revoke_by_token
        from_db = repo.by_token(token)

        expect(from_db.revoked_at).to be_within(5).of(session.revoked_at)
      end
    end
  end

  describe "#touch_by_token" do
    subject(:touch_by_token) { repo.touch_by_token(token) }

    let(:token) { crypto_service.generate_secret }
    let!(:session) do
      Factory.create(
        :session,
        token_digest: crypto_service.generate_sha_digest(token),
        last_activity_at: Time.now.utc - 60,
      )
    end

    it { is_expected.to be_a Pennywise::Structs::Session }

    it "updates the session's last_activity_at" do
      touch_by_token
      from_db = repo.by_token(token)

      expect(from_db.last_activity_at).to be > session.last_activity_at
    end

    context "when the session has an expiration date" do
      let!(:session) do
        Factory.create(
          :session,
          token_digest: crypto_service.generate_sha_digest(token),
          last_activity_at: Time.now.utc - 60,
          expired_at: Time.now.utc + (7200 - 60),
        )
      end

      it "updates the session's expired_at" do
        touch_by_token
        from_db = repo.by_token(token)

        expect(from_db.expired_at).to be > session.expired_at
      end
    end

    context "when the session is expired" do
      let!(:session) do
        Factory.create(
          :session,
          :expired,
          token_digest: crypto_service.generate_sha_digest(token),
          last_activity_at: Time.now.utc - 60,
        )
      end

      it { is_expected.to be_nil }

      it "does not update the session's last_activity_at or expired_at" do
        touch_by_token
        from_db = repo.by_token(token)

        expect(from_db).to have_attributes(last_activity_at: session.last_activity_at, expired_at: session.expired_at)
      end
    end

    context "when the session is revoked" do
      let!(:session) do
        Factory.create(
          :session,
          :revoked,
          token_digest: crypto_service.generate_sha_digest(token),
          last_activity_at: Time.now.utc - 60,
        )
      end

      it { is_expected.to be_nil }

      it "does not update the session's last_activity_at or expired_at" do
        touch_by_token
        from_db = repo.by_token(token)

        expect(from_db).to have_attributes(last_activity_at: session.last_activity_at, expired_at: session.expired_at)
      end
    end
  end
end
