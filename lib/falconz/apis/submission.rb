module Falconz
  module APIs
    module Submission 
      # Submit a local file for analysis.
      #
      # == Example
      #
      #   response = client.submit_file(file: "/path/to/local/file", environment_id: 300)
      # 
      #   # print job ID from response
      #   puts response["job_id"]
      #
      # @param options [Hash] the hashes to search for.
      # @return [Hash] 
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_file
      def submit_file(**options)
        options[:file] = File.open(options[:file], "r")
        response = post_request("/submit/file", options)
        options[:file].close
        return response
      end

      # Submit a file by URL for analysis.
      #
      # == Example
      #
      #   response = client.submit_url(url: "www.malicious-google.com/malware.exe", environment_id: 100, no_share_third_party: true)
      #
      #   # print job ID from response
      #   puts response["job_id"]
      #
      # @param options [Hash]
      # @return [Hash] 
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_url_to_file
      def submit_file_by_url(**options)
        post_request("/submit/url-to-file", options)
      end

      # Submit a url for analysis.
      #
      # == Example
      #
      #   response = client.submit_url(url: "www.malicious-google.com", environment_id: 100, experimental_anti_evasion: true)
      # 
      #   # print job ID from response
      #   puts response["job_id"]
      #
      # @param options [Hash]
      # @return [Hash] 
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_url_for_analysis
      def submit_url(**options)
        post_request("/submit/url-for-analysis", options)
      end

      # determine a SHA256 that an online file or URL submission will 
      # have when being processed by the system. Note: this is useful when looking up URL analysis
      #
      # @param options [Hash]
      # @return [Hash] 
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_hash_for_url
      def hash_for_url(url)
        post_request("/submit/hash-for-url", url: url)
      end

      # submit dropped file for analysis
      #
      # @param options [Hash]
      # @return [Hash] 
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/Submission/post_submit_dropped_file
      def submit_dropped_file(**options)
        post_request("/submit/dropped-file", options)
      end
    end
  end
end
