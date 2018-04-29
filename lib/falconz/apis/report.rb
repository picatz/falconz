module Falconz
  module APIs
    module Report 
      # return state of a submission
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__state
      def report_state(id)
        raise_if_id_is_not_valid(id)
        get_request("/report/#{id}/hash")
      end

      # return summary of a submission
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__summary
      def report_summary(id)
        raise_if_id_is_not_valid(id)
        get_request("/report/#{id}/hash")
      end

      # return summary of multiple submissions (bulk query)
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/post_report_summary
      def report_summary(**options)
        post_request("/report/summary", options)
      end

      # downloading report data (e.g. JSON, XML, PCAP)
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__file__type_
      def report_file(id, type)
        raise_if_id_is_not_valid(id)
        raise_if_report_file_type_is_not_valid(type)
        get_request("/report/#{id}/file/#{type}")
      end

      # retrieve an array of screenshots from a report in the Base64 format
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__screenshots
      def report_sreenshots(id)
        raise_if_id_is_not_valid(id)
        get_request("/report/#{id}/screenshots")
      end

      # retrieve all extracted/dropped binaries files for a report, as zip
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__dropped_files
      def report_droppedfiles(id)
        raise_if_id_is_not_valid(id)
        get_request("/report/#{id}/dropped-files")
      end

      private
      def raise_if_id_is_not_valid(id)
        unless id_is_in_probably_valid_format?(id)
          raise "need if in format: ‘jobId’ or ‘sha256:environmentId’"
        end
      end

      def id_is_in_probably_valid_format?(id)
        return false if id.nil?
        return false unless id.is_a? String
        return true 
      end

      VALID_REPORT_FILE_TYPES = {
        "xml":  "The XML report as application/xml content and *.gz compressed.",
        "json": "The JSON report as application/json content",
        "html": "The HTML report as text/html content and *.gz compressed",
        "pdf":  "The PDF report as application/pdf content",
        "maec": "The MAEC (4.1) report as application/xml content",
        "stix": "The STIX report as application/xml content",
        "misp": "The MISP XML report as application/xml content",
        "misp-json": "The MISP JSON report as application/json content",
        "openioc": "The OpenIOC (1.1) report as application/xml content",
        "bin": "The binary sample as application/octet-stream and *.gz compressed. Note: if the file was uploaded with ‘no_share_vt’ (i.e. not shared), this might fail.",
        "crt": "The binary sample certificate file (is available) as application/octet-stream content",
        "memory": "The process memory dump files as application/octet-stream and zip compressed.",
        "pcap": "The PCAP network traffic capture file as application/octet-stream and *.gz compressed."
      }

      def report_file_type_is_valid?(type)
        return true if VALID_REPORT_FILE_TYPES.keys.include? type.to_s.downcase
        false
      end

      def raise_if_report_file_type_is_not_valid(type)
        unless report_file_type_is_valid?(id)
          raise "Type requires https://www.reverse.it/docs/api/v2#/Report/get_report__id__file__type:\n#{VALID_REPORT_FILE_TYPES}"
        end
      end
    end
  end
end
