module Falconz
  module APIs
    module Search
      # Get summaries for a given hash.
      # 
      # == Example
      #   search_results = client.search_hash("e2442c82f3af5c6c72694ad670d385571418f64b998e2c470c3a5fcd18181932")
      #
      #   search_results.first["total_signatures"]
      #    # => 15
      # 
      # @param string [String] the hash to search for.
      # @return [Array<Hash>] the result(s) from the search.
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/Search/post_search_hash
      def search_hash(string)
        options = {}
        options[:hash] = string unless string.nil?
        raise "Requires a MD5, SHA1 or SHA256 hash" if options[:hash].nil?
        post_request("/search/hash", options)
      end
      
      # Get a summaries for any amount of given hashes.
      #
      # == Example
      #   search_results = client.search_hashes("e2442c82f3af5c6c72694ad670d385571418f64b998e2c470c3a5fcd18181932", "1cc406f6bf071bf5d96634cf9ab4ee94c2103e9b96207fdb37234536bb12bd50")
      # 
      #   search_results.count 
      #   # => 2
      #
      #   search_results.first["total_signatures"]
      #   # => 15
      #
      #   # print all search results to screen, as json
      #   puts search.to_json
      #
      # @param strings [Array<String>] the hashes to search for.
      # @return [Array<Hash>] the results from the search.
      #   
      # https://www.hybrid-analysis.com/docs/api/v2#/Search/post_search_hashes
      def search_hashes(*strings)
        options = {}
        options[:hashes] = strings unless strings.nil? or strings.empty?
        raise "Requires MD5, SHA1 or SHA256 hashes" if options[:hashes].nil?
        post_request("/search/hashes", options)
      end
     
      # Search the database using search terms.
      #
      # == Example
      #   pdf_results = client.search_terms(filetype: "pdf")
      #
      #   # count malicious pdfs from results
      #   pdf_results["result"].select { |r| r["verdict"] == "malicious" }.count
      #
      # == Example 
      #   ransomware_results = client.search_terms(tag: "ransomware")
      #   
      #   ransomware_results["count"]
      #   # => 196
      #
      # @param options [Hash] the hashes to search for.
      # @return [Array<Hash>] the results from the search.
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/Search/post_search_terms
      def search_terms(**options)
        post_request("/search/terms", options)
      end
    end
  end
end
