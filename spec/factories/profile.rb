# frozen_string_literal: true

Factory.define(:profile, struct_namespace: Pennywise::Structs) do |f|
  f.association :identity

  f.first_name { Faker::Name.first_name }
  f.last_name { Faker::Name.last_name }
  f.avatar_url { Faker::Avatar.image }
  f.timestamps
end
