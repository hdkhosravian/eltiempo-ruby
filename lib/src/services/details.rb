module Lib
  module Src
    module Services
      class Details
        attr_reader :errors, :forcast, :type, :temp

        def initialize(temp, type)
          @temp  = temp
          @type  = type
          @forcast  = ""
          @errors  = []
        end

        def process
          find_forcast_detail
          render_result
        end

        private

        def render_result
          { object: forcast, errors: errors }
        end

        def find_forcast_detail
          send(type)
        end

        def today
          day = Time.now.wday
          min = temp.xpath("//var[icon[text() = 4]]//data//forecast[@data_sequence=#{day}]").attribute('value').value
          max = temp.xpath("//var[icon[text() = 5]]//data//forecast[@data_sequence=#{day}]").attribute('value').value
          @forcast = "min: #{min}\nmax: #{max}"
        end

        def min
          sum_of_forcasts = 0
          min_forcasts = temp.xpath('//var[icon[text() = 4]]//data')
          min_forcasts.children.each do |forcast|
            sum_of_forcasts += forcast.attribute('value').value.to_f
          end

          @forcast = (sum_of_forcasts / min_forcasts.children.count).round(2)
        end
        
        def max
          sum_of_forcasts = 0
          max_forcasts = temp.xpath('//var[icon[text() = 5]]//data')
          max_forcasts.children.each do |forcast|
            sum_of_forcasts += forcast.attribute('value').value.to_f
          end

          @forcast = (sum_of_forcasts / max_forcasts.children.count).round(2)
        end
      end
    end
  end
end