# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Repos::ProfileRepo do
  subject(:repo) { app["repos.profile_repo"] }

  describe "#by_pk" do
    subject(:by_pk) { repo.by_pk(identity_id) }

    context "when a profile with a matching identity_id exists" do
      let(:identity_id) { Factory.create(:profile).identity_id }

      it "returns a Pennywise::Structs::Profile" do
        expect(by_pk).to be_a(Pennywise::Structs::Profile).and(have_attributes(identity_id:))
      end
    end

    context "when a profile with a matching identity_id does not exist" do
      let(:identity_id) { Faker::Internet.uuid }

      it { expect(by_pk).to be_nil }
    end
  end
end
