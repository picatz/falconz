module Falconz
  module APIs
    module System
      # return heartbeat
      #
      # == Example
      #   client = Falconz.client.new
      #
      #   client.system_heartbeat do |response|
      #     # do something with the response
      #     puts response.to_json
      #   end
      #
      # == Example without Block Syntax
      #   client = Falconz.client.new
      #
      #   response = client.system_heartbeat
      #
      # https://www.hybrid-analysis.com/docs/api/v2#/System/get_system_heartbeat
      def system_heartbeat(wait = 15)
        return get_request("/system/heartbeat") unless block_given?
        while true
          yield get_request("/system/heartbeat")
          sleep wait
        end
      end

      # check the number of seconds since last update
      # @see #system_heartbeat
      def number_of_seconds_since_last_update
        system_heartbeat["number_of_seconds_since_last_update"]
      end

      # check the total submissions in the system
      # https://www.hybrid-analysis.com/docs/api/v2#/System/get_system_total_submissions
      def total_submissions_in_system
        get_request("/system/total-submissions")["value"]
      end

      # get the in progress jobs
      # https://www.hybrid-analysis.com/docs/api/v2#/System/get_system_in_progress
      def in_progress
        return get_request("/system/in-progress")["values"] unless block_given?
        get_request("/system/in-progress")["values"].each do |value| 
          hash, env = value.split(":")
          yield hash, env 
        end
      end

      # return information about configured backend nodes
      # https://www.hybrid-analysis.com/docs/api/v2#/System/get_system_backend
      def backend
        get_request("/system/backend")
      end

      def environments
        return get_request("/system/environments") unless block_given?
        get_request("/system/environments").each do |environment|
          yield environment
        end
      end

      def number_of_environments
        environments.count
      end

      def find_environment_by_id(id)
        id = id.to_i
        environments do |env|
          return env if env["id"] == id
        end
      end

      def environment_ids(refresh: false)
        if refresh or @environment_ids.nil?
          @enviromment_ids = environments.map { |env| env["id"] } 
        end
        return @environment_ids unless block_given?
        @environment_ids.each { |env| yield id }
      end

      # return environments
      def environments_busy_percentages
        envs = {}
        environments do |env|
          if env["busy_virtual_machines"] == 0 || env["total_virtual_machines"] == 0
            envs[env["id"]] = 0
          else
            envs[env["id"]] = env["busy_virtual_machines"].to_f / env["total_virtual_machines"]
          end
        end 
        return envs unless block_given?
        envs.each do |k, v|
          yield v k 
        end
      end

      # check if a given environment ID is a windows system 
      def environment_windows?(id)
        env = find_environment_by_id(id)
        return nil if env.nil?
        return true if env["architecture"] == "WINDOWS"
        false
      end

      # check if a given environment ID is a linux system 
      def environment_linux?(id)
        env = find_environment_by_id(id)
        return nil if env.nil?
        return true if env["architecture"] == "LINUX"
        false
      end

      # a full system state query, including all available 
      # action scripts, environments, files in progress, etc.
      # https://www.reverse.it/docs/api/v2#/System/get_system_state
      def system_state
        get_request("/system/state")
      end

      # return information about the instance version
      # https://www.reverse.it/docs/api/v2#/System/get_system_version
      def system_version
        get_request("/system/version")
      end

      # return information about queue size
      # https://www.reverse.it/docs/api/v2#/System/get_system_queue_size
      def queue_size
        get_request("/system/queue-size")["value"]
      end
    end
  end
end
