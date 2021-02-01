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
            item = list.search(
              "report location data name[text() = '#{name}']"
            )
            
            unless item.empty?
              @temp_id = item.attribute('id').value
            else
              items = list.search(
                "report location data name[contains('#{name}')]"
              )

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
        end
      end
    end
  end