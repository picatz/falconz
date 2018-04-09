module Falconz
  module APIs
    module Report 
      def report_state(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/hash", options)
      end

      def report_summary(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/hash", options)
      end

      def report_file(id, type, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        raise "Type requirest https://www.reverse.it/docs/api/v2#/Report/get_report__id__file__type_" if type.nil?
        get_request("/report/#{id}/file/#{type}", options)
      end

      def report_sreenshots(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/screenshots", options)
      end

      def report_droppedfiles(id, **options)
        raise "ID in one of format: ‘jobId’ or ‘sha256:environmentId’" if id.nil?
        get_request("/report/#{id}/dropped-files", options)
      end
    end
  end
end
