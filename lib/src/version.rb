module Lib
  module Src
    class Version < ::Dry::CLI::Command
      desc "Print version"

      def call(*)
        puts '1.0.0'
      end
    end
  end
end