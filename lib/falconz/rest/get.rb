module Falconz
  module REST
    # HTTP 1.1 GET request method to make on the API endpoint.
    #
    # This is a module that is used in pretty much all the API
    # modules in order to talk to the API endpoint.
    module GET
      def get_request(path)
        response = HTTParty.get(url + path, headers: header)
        return response if response.success?
        raise RuntimeError, response
      end
    end
  end
end
