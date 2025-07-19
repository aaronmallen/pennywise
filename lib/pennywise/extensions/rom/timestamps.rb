# frozen_string_literal: true

module Pennywise
  module Extensions
    module ROM
      module Timestamps
        def add_timestamps(data)
          now = Sequel.function(:now)
          data.merge(created_at: now, updated_at: now)
        end

        def touch(data)
          data.merge(updated_at: Sequel.function(:now))
        end
      end
    end
  end
end

ROM::Changeset::PipeRegistry.singleton_class.prepend(Pennywise::Extensions::ROM::Timestamps)
