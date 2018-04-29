module Falconz
  module APIs
    module Report 
      # return state of a submission
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__state
      def report_state(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/hash", options)
      end

      # return summary of a submission
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__summary
      def report_summary(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/hash", options)
      end

      # return summary of multiple submissions (bulk query)
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/post_report_summary
      def report_summary(**options)
        post_request("/report/summary", options)
      end

      # downloading report data (e.g. JSON, XML, PCAP)
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__file__type_
      def report_file(id, type, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        raise "Type requirest https://www.reverse.it/docs/api/v2#/Report/get_report__id__file__type_" if type.nil?
        get_request("/report/#{id}/file/#{type}", options)
      end

      # retrieve an array of screenshots from a report in the Base64 format
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__screenshots
      def report_sreenshots(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/screenshots", options)
      end

      # retrieve all extracted/dropped binaries files for a report, as zip
      # https://www.hybrid-analysis.com/docs/api/v2#/Report/get_report__id__dropped_files
      def report_droppedfiles(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/dropped-files", options)
      end
    end
  end
end
