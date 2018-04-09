module Falconz
  module APIs
    module Key 
      # return information about the used API key
      def current_key(**options)
        get_request("/key/current", options)
      end
    end
  end
end
