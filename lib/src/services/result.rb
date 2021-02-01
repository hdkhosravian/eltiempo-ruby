require_relative './list'
require_relative './find'
require_relative './show'
require_relative './details'

module Lib
    module Src
      module Services
        class Result
          attr_reader :errors, :forcast, :name, :type
  
          def initialize(name, type)            
            @name  = name
            @type  = type
            @forcast  = ""
            @errors  = []
          end
  
          def process
            list = get_temps_list
            location_id = get_temp_find(list) if errors.empty?
            temp = get_temp_show(location_id) if errors.empty?
            get_temp_details(temp) if errors.empty?

            render_result
          end
  
          private
  
          def render_result
            { object: forcast, errors: errors }
          end

          def get_temps_list
            result = Lib::Src::Services::List.new.process
            @errors.concat(result[:errors])
            result[:object]
          end

          def get_temp_find(list)
            result = Lib::Src::Services::Find.new(list, name).process
            @errors.concat(result[:errors])
            result[:object]
          end

          def get_temp_show(location_id)
            result = Lib::Src::Services::Show.new(location_id).process
            @errors.concat(result[:errors])
            result[:object]
          end

          def get_temp_details(temp)
            result = Lib::Src::Services::Details.new(temp, type).process
            @errors.concat(result[:errors])
            @forcast = result[:object]
          end
        end
      end
    end
  end