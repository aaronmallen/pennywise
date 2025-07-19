# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pennywise::URL do
  describe ".postgres_url_from_env" do
    subject(:postgres_url) { described_class.postgres_url_from_env(**overrides) }

    before do
      stub_const(
        "ENV",
        {
          "DATABASE_NAME" => "postgres",
          "DATABASE_HOST" => "localhost",
          "DATABASE_PASSWORD" => "password",
          "DATABASE_PORT" => 5432,
          "DATABASE_USER" => "postgres",
        },
      )
    end

    let(:overrides) { {} }

    it "returns the default postgres url" do
      expect(postgres_url).to eq("postgres://postgres:password@localhost:5432/postgres")
    end

    context "with overrides" do
      let(:overrides) { { user: "myuser", password: "secret", host: "db.example.com", port: 6543, database: "mydb" } }

      it "returns the overridden postgres url" do
        expect(postgres_url).to eq("postgres://myuser:secret@db.example.com:6543/mydb")
      end
    end
  end

  describe ".redis_url_from_env" do
    subject(:redis_url) { described_class.redis_url_from_env(**overrides) }

    before do
      stub_const(
        "ENV",
        { "REDIS_HOST" => "localhost", "REDIS_PASSWORD" => "password", "REDIS_PORT" => 6379, "REDIS_DATABASE" => 0 },
      )
    end

    let(:overrides) { {} }

    it "returns the default redis url" do
      expect(redis_url).to eq("redis://password@localhost:6379/0")
    end

    context "with overrides" do
      let(:overrides) { { password: "redispass", host: "redis.example.com", port: 6380, database: 2 } }

      it "returns the overridden redis url" do
        expect(redis_url).to eq("redis://redispass@redis.example.com:6380/2")
      end
    end
  end
end
