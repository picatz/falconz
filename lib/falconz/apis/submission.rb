module Falconz
  module APIs
    module Submission 
      # submit a local file for analysis
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_file
      def submit_file(**options)
        options[:file] = File.open(options[:file], "r")
        response = post_request("/submit/file", options)
        options[:file].close
        return response
      end
     
      # submit a file by url for analysis 
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_url_to_file
      def submit_file_by_url(**options)
        post_request("/submit/url-to-file", options)
      end
      
      # submit a url for analysis
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_url_for_analysis
      def submit_url(**options)
        post_request("/submit/url-for-analysis", options)
      end
      
      # determine a SHA256 that an online file or URL submission will 
      # have when being processed by the system. Note: this is useful when looking up URL analysis
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_hash_for_url
      def hash_for_url(url)
        post_request("/submit/url-for-analysis", url: url)
      end
     
      # submit dropped file for analysis
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_dropped_file
      def submit_dropped_file(**options)
        post_request("/submit/dropped-file", options)
      end
    end
  end
end
