require_relative "rest/get.rb"
require_relative "rest/post.rb"
require_relative "apis/search.rb"
require_relative "apis/key.rb"
require_relative "apis/system.rb"
require_relative "apis/submission.rb"
require_relative "apis/feed.rb"
require_relative "apis/report.rb"

module Falconz
  class Client 
    # Need some special REST API powers.
    include REST::GET
    include REST::POST
    
    # All of the magic API methods, nestled away
    # into their own modules.
    include APIs::Key
    include APIs::Search
    include APIs::System
    include APIs::Submission
    include APIs::Feed
    include APIs::Report

    # Client HTTP header information.
    attr_accessor :header

    # Client HTTP base URL.
    attr_accessor :url

    # When initializing a Client, you can optionally specify the base API (v2) URL
    # and the API key to be used for communication. These can both be changed later on. 
    #
    # Note: If not specified, the HYBRID_ANALYSIS_API_KEY environment variable is used.
    def initialize(url: "https://www.hybrid-analysis.com/api/v2", key: ENV["HYBRID_ANALYSIS_API_KEY"])
      @url = url

      @header = { 
        "User-Agent" => "Falcon Sandbox", 
        "api-key" => key
      }
    end
   
    def valid_user_agent?
      return true if @header["api-key"] && @header["User-Agent"] == "Falcon Sandbox"
      false
    end

    def api_key?
      return true if @header["api-key"]
      false
    end

    def api_key
      @header["api-key"]
    end
    
    def api_key=(k)
      @header["api-key"] = k
    end
  end
end
