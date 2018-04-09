module Falconz
  module REST
    module GET
      def get_request(path, **options)
        if options[:query]
          response = HTTParty.get(Falconz::Client::URL + path, 
                                  headers: Falconz::Client::HEADER, 
                                  query: options[:query])
        else
          response = HTTParty.get(Falconz::Client::URL + path, 
                                  headers: Falconz::Client::HEADER)
        end
        if response.success?
          return response unless options[:json]
          return response.body
        else
          binding.pry
          raise response.to_h
        end
      end
    end
  end
end
