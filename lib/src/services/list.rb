module Lib
  module Src
    module Services
      class List
        attr_reader :errors, :temps

        def initialize
          @temps  = ""
          @errors  = []
        end

        def process
          get_temps_list
          render_result
        end

        private

        def render_result
          { object: temps, errors: errors }
        end

        def get_temps_list
          resp = Faraday.get(ENV["TIEMPO_URL"]) do |req|
            # we can read these attributes from user inputs too
            req.params['api_lang'] = ENV["API_LANG"]
            req.params['division'] = ENV["DEVISION"]
            req.params['affiliate_id'] = ENV["AFFILIATE_ID"]
          end

          if resp.status == 200
            body = Nokogiri.XML(resp.body)

            unless(body.search('report error').empty?)
              body.search('report error').each do |error|
                @errors << error.content
              end
            else
              @temps = body
            end
          end
        end
      end
    end
  end
end