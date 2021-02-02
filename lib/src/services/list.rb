module Lib
  module Src
    module Services
      class List
        attr_reader :errors, :locations

        def initialize
          @locations  = ""
          @errors  = []
        end

        def process
          get_locations_list
          render_result
        end

        private

        def render_result
          { object: locations, errors: errors }
        end

        def get_locations_list
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
              @locations = body
            end
          end
        end
      end
    end
  end
end