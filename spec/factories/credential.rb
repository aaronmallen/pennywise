# frozen_string_literal: true

Factory.define(:credential, struct_namespace: Pennywise::Structs) do |f|
  crypto_service = Hanami.app["services.crypto_service"]

  f.association :identity, :active
  f.sequence(:email) { |n| Faker::Internet.email.gsub("@", "#{n}@") }
  f.digest { crypto_service.generate_password_digest(Faker::Internet.password(min_length: 8)) }

  f.trait :locked do |t|
    t.failed_attempts { 3 }
    t.locked_until { Time.now.utc + 300 }
  end
end
