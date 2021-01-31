require "bundler/setup"
require "dry/cli"

# Src files
require_relative './src/version'

module Lib
  module Eltiempo
    extend Dry::CLI::Registry
    extend Lib::Src

    register "version", Lib::Src::Version, aliases: ["-v", "--v", "--version"]
  end
end
