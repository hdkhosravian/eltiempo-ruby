module Lib
    module Src
      module Services
        class Show
          attr_reader :errors, :temp, :location_id

          def initialize(location_id)
            @location_id  = location_id
            @temp  = ""
            @errors  = []
          end

          def process
            get_temp_show
            render_result
          end

          private

          def render_result
            { object: temp, errors: errors }
          end

          def get_temp_show
            resp = Faraday.get(ENV["TIEMPO_URL"]) do |req|
              req.params['api_lang'] = ENV["API_LANG"]
              req.params['localidad'] = location_id
              req.params['affiliate_id'] = ENV["AFFILIATE_ID"]
            end

            if resp.status == 200
              body = Nokogiri.XML(resp.body)
  
              unless(body.search('report error').empty?)
                body.search('report error').each do |error|
                  @errors << error.content
                end
              else
                @temp = body
              end
            end
          end
        end
      end
    end
  end