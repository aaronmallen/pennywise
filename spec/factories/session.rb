# frozen_string_literal: true

Factory.define(:session, struct_namespace: Pennywise::Structs) do |f|
  crypto_service = Hanami.app["services.crypto_service"]

  f.association :identity, :active

  f.token_digest { crypto_service.generate_sha_digest(crypto_service.generate_secret) }
  f.ip_address { Faker::Internet.ip_v4_address }
  f.user_agent { Faker::Internet.user_agent }

  f.trait :expired do |t|
    t.expired_at { Time.now.utc - 60 }
  end

  f.trait :revoked do |t|
    t.revoked_at { Time.now.utc - 60 }
  end
end
