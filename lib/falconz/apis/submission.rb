module Falconz
  module APIs
    module Submission 
      # submit a local file for analysis
      def submit_file(**options)
        options[:file] = File.open(options[:file], "r")
        response = post_request("/submit/file", options)
        options[:file].close
        return response
      end
     
      # submit a file by url for analysis 
      def submit_file_by_url(**options)
        post_request("/submit/url-to-file", options)
      end
      
      # submit a url for analysis 
      def submit_url(**options)
        post_request("/submit/url-for-analysis", options)
      end
     
      # submit dropped file for analysis 
      def submit_dropped_file(**options)
        post_request("/submit/dropped-file", options)
      end

      # determine a SHA256 that an online file or URL 
      # submission will have when being processed by 
      # the system. Note: this is useful when looking 
      # up URL analysis
      def hash_from_url(**options)
        post_request("/submit/hash-for-url", options)
      end
    end
  end
end
