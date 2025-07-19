# frozen_string_literal: true

RSpec.describe Pennywise::Actions::Sessions::Create do
  subject(:action) { app["actions.sessions.create"] }

  let(:crypto_service) { app["services.crypto_service"] }

  describe "#call" do
    subject(:call) { action.call(params) }

    context "when given valid params" do
      let(:password) { Faker::Internet.password(min_length: 8) }
      let(:identity) { Factory.create(:identity, :with_profile) }

      let(:credential) do
        Factory.create(:credential, identity:, digest: crypto_service.generate_password_digest(password))
      end

      let(:params) { { session: { email: credential.email, password:, remember: true } } }

      it { is_expected.to be_a_redirect }

      it "renders a flash message" do
        expect(call.flash.next[:success]).to eq("Welcome back #{identity.profile.first_name}!")
      end

      context "when credentials are wrong" do
        let(:params) do
          { session: { email: credential.email, password: Faker::Internet.password(min_length: 8), remember: true } }
        end

        it { is_expected.to be_unprocessable }

        it "renders a flash message" do
          expect(call.flash.now[:error]).to be_a(String)
        end
      end

      context "when creating the session fails" do
        before do
          mock_operation = instance_double(Pennywise::Operations::CreateSession)
          allow(Pennywise::Operations::CreateSession).to receive(:new).and_return(mock_operation)
          allow(mock_operation).to receive(:call).and_return(Failure())
        end

        it { is_expected.to be_unprocessable }

        it "renders a flash message" do
          expect(call.flash.now[:error]).to eq(
            "Something went wrong. If the problem persists please contact your admin.",
          )
        end
      end
    end

    context "when given invalid params", skip: "https://github.com/aaronmallen/pennywise/issues/5" do
      let(:params) { { session: {} } }

      it { is_expected.to be_unprocessable }
    end
  end
end
