module Falconz
  module APIs
    module Key 
      # return information about the used API key
      # https://www.hybrid-analysis.com/docs/api/v2#/Key/get_key_current
      def current_key
        get_request("/key/current")
      end
    end
  end
end
