module Falconz
  module APIs
    # A module consisting of the method associated with the 
    # Feed section of the API.
    #
    # @author Kent 'picat' Gruber
    module Feed
      # access a feed of last 250 reports over 24h
      #
      # == Example
      #   # create a new client
      #   client = Falconz.client.new
      #
      #   client.latest_feed do |data|
      #     # do something with the data
      #     puts data.to_json
      #   end
      #
      #   # or, if you'd like, you can be a fancy shamncy pants 
      #
      #   client.latest_feed { |data| puts data.to_json }
      #
      #   feed = client.latest_feed
      # 
      # @return 
      # https://www.hybrid-analysis.com/docs/api/v2#/Feed/get_feed_latest
      def latest_feed
        # return response unless block was given ( like the in-line example )
        return get_request('/feed/latest') unless block_given?
        # capture response
        response = get_request('/feed/latest')
        # raise error (built out of the response) unless everything is ok
        raise "response not ok: #{response}" unless Falconz.response_is_ok?(response)
        # raise error unless there is any data
        raise "no data to iterate through in response #{response}" unless response['data'] or !response['data'].zero?
        response['data'].each do |data|
          yield data
        end
      end

      # A little wrapper method to #latest_feed that returns the count
      # of the amount of data found in the feed.
      # 
      # == Example
      #   # create a new client
      #   client = Falconz.client.new
      #   
      #   # print latest feed found to the screen
      #   puts client.latest_feed_count
      #
      # @return [Integer]
      # @see #latest_feed
      def latest_feed_count
        # capture response
        response = latest_feed   
        # raise error (built out of the response) unless everything is ok
        raise response unless Falconz.response_is_ok?(response)
        # raise error unless there is any count in the response
        raise "no count found in response #{response}" unless response['count']
        # return the count
        response["count"] 
      end
    end
  end
end
