module Falconz
  module REST
    module GET
      def get_request(path, json: false, **options)
        response = HTTParty.get(url + path, headers: header)
        if response.success?
          return response.body if json
          return response 
        else
          binding.pry
          raise response.to_h
        end
      end
    end
  end
end
