require 'bundler/setup'
require 'nokogiri'
require 'dry/cli'
require 'faraday'
require 'dotenv'

# Src files
require_relative './src/cli/version'
require_relative './src/cli/min_average'
require_relative './src/cli/max_average.rb'
require_relative './src/cli/today_temperature'

# I prefer to use .env instead of using hardcoding
# for a gem, we can use an initializer and config it in the project, not inside the code
Dotenv.load('./.env')

module Lib
  module Eltiempo
    extend Dry::CLI::Registry
    extend ::Lib::Src

    register 'min', ::Lib::Src::Cli::MinAverage, aliases: ['-av_min', '-av-min']
    register 'max', ::Lib::Src::Cli::MaxAverage, aliases: ['-av_max', '-av-max']
    register 'today', ::Lib::Src::Cli::TodayTemperature, aliases: ['-today', '-Today']
    register 'version', ::Lib::Src::Cli::Version, aliases: ['-v', '--v', '--version']
  end
end
