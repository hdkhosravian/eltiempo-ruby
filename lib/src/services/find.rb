module Lib
    module Src
      module Services
        class Find
          attr_reader :errors, :temp_id, :name, :list

          def initialize(list, name)
            @list  = list
            @name  = name
            @temp_id  = ""
            @errors  = []
          end

          def process
            find_temp_id
            render_result
          end

          private

          def render_result
            { object: temp_id, errors: errors }
          end

          def find_temp_id
            item = find_city(name)

            unless item.empty? || item.count > 1
              @temp_id = item.attribute('id').value
            else
              items = find_city(name)

              # please consider we can use I18N for our messages and same with our ENV["API_LANG"]
              # but for this project I used english and make it hardcode.
              error = "we could not find the #{name}"
              error += ", did you mean:" unless items.empty?
              items.each do |item|
                error += "\n#{item.content}"
              end

              @errors << error
            end
          end

          def find_city(city)
            return list.xpath("//report//location//data//name[
              contains(
                translate(
                  text(),
                  'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                  'abcdefghijklmnopqrstuvwxyz'),
                '#{city.downcase}')
            ]")
          end
        end
      end
    end
  end