# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Repos::IdentityRepo do
  subject(:repo) { app["repos.identity_repo"] }

  describe "#by_pk" do
    subject(:by_pk) { repo.by_pk(id) }

    context "when an identity with a matching id exists" do
      let(:id) { Factory.create(:identity).id }

      it "returns a Pennywise::Structs::Identity" do
        expect(by_pk).to be_a(Pennywise::Structs::Identity).and(have_attributes(id:))
      end
    end

    context "when an identity with a matching id does not exist" do
      let(:id) { Faker::Internet.uuid }

      it { expect(by_pk).to be_nil }
    end
  end
end
