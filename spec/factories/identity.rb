# frozen_string_literal: true

Factory.define(:identity, struct_namespace: Pennywise::Structs) do |f|
  f.timestamps

  Pennywise::Types::IdentityStatus.each_value do |status|
    f.trait status.to_sym do |t|
      t.status { status }
    end
  end
end
