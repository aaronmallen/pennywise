# frozen_string_literal: true

Dir[File.expand_path("seeds/default/**/*.rb", File.dirname(__FILE__))].each { |seed| load seed }
Dir[File.expand_path("seeds/#{Hanami.env}/**/*.rb", File.dirname(__FILE__))].each { |seed| load seed }
