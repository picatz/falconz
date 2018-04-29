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
    include REST::GET
    include REST::POST
    include APIs::Key
    include APIs::Search
    include APIs::System
    include APIs::Submission
    include APIs::Feed
    include APIs::Report

    def initialize
      @url = "https://www.hybrid-analysis.com/api/v2"

      @header = { 
        "User-Agent" => "Falcon Sandbox", 
        "api-key" => ENV["HYBRID_ANALYSIS_API_KEY"]
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

    def url
      @url
    end

    def url=(u)
      @url = u
    end

    def header
      @header
    end

    def header=(h)
      @header
    end
  end
end
