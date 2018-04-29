module Falconz
  module APIs
    module Search
      # summary for given hash
      # https://www.hybrid-analysis.com/docs/api/v2#/Search/post_search_hash
      def search_hash(string)
        options = {}
        options[:hash] = string unless string.nil?
        raise "Requires a MD5, SHA1 or SHA256 hash" if options[:hash].nil?
        post_request("/search/hash", options)
      end
      
      # summary for given hashes
      # https://www.hybrid-analysis.com/docs/api/v2#/Search/post_search_hashes
      def search_hashes(*strings)
        options = {}
        options[:hashes] = strings unless strings.nil? or strings.empty?
        raise "Requires MD5, SHA1 or SHA256 hashes" if options[:hashes].nil?
        post_request("/search/hashes", options)
      end
     
      # search the database using search terms
      # https://www.hybrid-analysis.com/docs/api/v2#/Search/post_search_terms
      def search_terms(**options)
        post_request("/search/terms", options)
      end
    end
  end
end
