require './lib/src/services/result'

module Lib
  module Src
    module Cli
      class TodayTemperature < ::Dry::CLI::Command
        desc "min and max of today temperatures"

        argument :city, required: true, desc: "name of the city"

        def call(city)
          render_result(city)
        end

        private

        def render_result(city)
          result = Lib::Src::Services::Result.new(city[:city], 'today').process
          if result[:errors].empty?
            puts result[:object]
          else
            puts result[:errors]
          end
        end
      end
    end
  end
end