module Falconz
  module APIs
    module Feed
      # access a feed of last 250 reports over 24h
      def latest_feed(**options)
        get_request("/feed/latest", options)
      end
    end
  end
end
