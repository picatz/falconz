require_relative "rest/get.rb"
require_relative "rest/post.rb"
require_relative "apis/search.rb"
require_relative "apis/key.rb"
require_relative "apis/system.rb"
require_relative "apis/submission.rb"

module Falconz
  class Client 
    include REST::GET
    include REST::POST
    include APIs::Key
    include APIs::Search
    include APIs::System
    include APIs::Submission

    URL = "https://www.hybrid-analysis.com/api/v2"

    HEADER = { 
      "User-Agent": "Falcon Sandbox", 
      "api-key": ENV["HYBRID_ANALYSIS_API_KEY"]
    }
  end
end
