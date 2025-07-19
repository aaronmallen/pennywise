# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::Operations::CreateSession do
  subject(:operation) { app["operations.create_session"] }

  let(:session_repo) { app["repos.session_repo"] }
  let(:sessions) { app["relations.sessions"] }

  describe "#call" do
    subject(:call) { operation.call(identity, request, remember:) }

    before do
      %w[HTTP_X_FORWARDED_FOR HTTP_X_REAL_IP REMOTE_ADDR HTTP_USER_AGENT].each do |header|
        allow(request).to receive(:get_header).with(header).and_return(mock_header[header])
      end
    end

    let(:identity) { Factory.create(:identity) }
    let(:ip) { nil }
    let(:request) { instance_double(Hanami::Action::Request, ip: ip) }
    let(:remember) { false }
    let(:mock_header) { {} }

    it { is_expected.to be_success }
    it { expect { call }.to change(sessions, :count).by(1) }

    it "returns a token" do
      expect(call.value!).to be_a(String)
    end

    context "when no ip headers are present but the request has an ip" do
      let(:ip) { Faker::Internet.ip_v4_address }

      it "creates a session with the ip" do
        token = call.value!
        session = session_repo.by_token(token)

        expect(session.ip_address).to eq(ip)
      end
    end

    context "when HTTP_X_FORWARDED_FOR is present" do
      let(:ip) { Faker::Internet.ip_v4_address }
      let(:mock_header) { { "HTTP_X_FORWARDED_FOR" => "#{ip},#{Faker::Internet.ip_v4_address}" } }

      it "creates a session with the ip from HTTP_X_FORWARDED_FOR" do
        token = call.value!
        session = session_repo.by_token(token)

        expect(session.ip_address).to eq(ip)
      end
    end

    context "when HTTP_X_REAL_IP is present" do
      let(:ip) { Faker::Internet.ip_v4_address }
      let(:mock_header) { { "HTTP_X_REAL_IP" => ip } }

      it "creates a session with the ip from HTTP_X_REAL_IP" do
        token = call.value!
        session = session_repo.by_token(token)

        expect(session.ip_address).to eq(ip)
      end
    end

    context "when REMOTE_ADDR is present" do
      let(:ip) { Faker::Internet.ip_v4_address }
      let(:mock_header) { { "REMOTE_ADDR" => ip } }

      it "creates a session with the ip from REMOTE_ADDR" do
        token = call.value!
        session = session_repo.by_token(token)

        expect(session.ip_address).to eq(ip)
      end
    end

    context "when HTTP_USER_AGENT is present" do
      let(:user_agent) { Faker::Internet.user_agent }
      let(:mock_header) { { "HTTP_USER_AGENT" => user_agent } }

      it "creates a session with the user agent" do
        token = call.value!
        session = session_repo.by_token(token)

        expect(session.user_agent).to eq(user_agent)
      end
    end

    context "when remember is true" do
      let(:remember) { true }

      it "creates a session that does not expire" do
        token = call.value!
        session = session_repo.by_token(token)

        expect(session.expired_at).to be_nil
      end
    end

    context "when creating the session raises an error" do
      before { allow_any_instance_of(Pennywise::Repos::SessionRepo).to receive(:create).and_raise(StandardError) }

      it { is_expected.to be_failure }
    end
  end
end
