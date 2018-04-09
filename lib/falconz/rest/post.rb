module Falconz
  module REST
    module POST 
      def post_request(path, json: false, **options)
        response = HTTParty.post(Falconz::Client::URL + path, 
                                headers: Falconz::Client::HEADER, 
                                body: options)
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
