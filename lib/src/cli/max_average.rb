require './lib/src/services/result'

module Lib
  module Src
    module Cli
      class MaxAverage < ::Dry::CLI::Command
        desc "Maximum average of temperature of the week"

        argument :city, required: true, desc: "name of the city"

        def call(city)
          render_result(city)
        end

        private

        def render_result(city)
          result = Lib::Src::Services::Result.new(city[:city], 'max').process
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