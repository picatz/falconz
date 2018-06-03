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
        jobs = get_request("/system/in-progress")["values"].map do |job| 
          kv = {}
          kv[:hash], kv[:environment] = job.split(":")
          kv
        end
        return jobs unless block_given?
        jobs.each do |job|
          yield job
        end
      end

      # number of jobs currently being processed
      # @see #in_progress
      def in_progress_count
        get_request("/system/in-progress")["values"].count
      end

      # return information about configured backend nodes
      #
      # == Example
      #   
      #   client = Falconz.client.new
      #
      #   backend_information = client.backend
      #
      #   # example of accessing specific information from hash
      #   puts backend_information["version"]
      #
      #   # all the keys in the hash
      #   puts backend_information.keys
      #
      #   # count the number of backend nodes
      #   puts backend_information["nodes"].count
      #
      #   # you can get hell'a fancy
      #   client.backend["nodes"].map { |node| node["environments"].map { |e| [e["architecture"], e["analysis_mode"]] } }.flatten(1).uniq.each do |arch, mode|
      #     puts "The " + arch + " architecture supports " + mode + " level analysis." 
      #   end
      #  
      # @return [Hash] all the information about the system backend
      # https://www.hybrid-analysis.com/docs/api/v2#/System/get_system_backend
      def backend
        get_request("/system/backend")
      end

      # return information about available execution environments
      # https://www.hybrid-analysis.com/docs/api/v2#/System/get_system_environments
      def environments
        return get_request("/system/environments") unless block_given?
        get_request("/system/environments").each do |environment|
          yield environment
        end
      end

      # return the number of environments in the system
      def number_of_environments
        environments.count
      end

      # find an environment by an ID
      def find_environment_by_id(id)
        id = id.to_i
        environments do |env|
          return env if env["id"] == id
        end
      end

      # list available environment IDs
      def environment_ids(refresh: false)
        if refresh or @environment_ids.nil?
          @environment_ids = environments.map { |env| env["id"] } 
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
      #
      # == Example
      #
      #   client = Falconz.client.new
      #   
      #   # get system version info, as a hash
      #   version_info = client.system_version
      #   # => {"instance"=>"8.0-5305cf9", "sandbox"=>"8.10", "api"=>"2.1.5"}
      #
      #   # iterate over each lil'bit of information
      #   version_info.each do |name, value|
      #     puts name + " " + value
      #   end
      #
      #   # you can also access the information directly
      #   puts "found API version " + version_info["api"]
      # 
      # https://www.reverse.it/docs/api/v2#/System/get_system_version
      def system_version
        get_request("/system/version")
      end

      # return information about system queue size
      #
      # == Example
      #
      #   client = Falconz.client.new
      #   
      #   # print the system queue size to the screen
      #   puts client.system_queue_size
      #
      # https://www.reverse.it/docs/api/v2#/System/get_system_queue_size
      def system_queue_size
        @cached_queue_size = get_request("/system/queue-size")["value"]
      rescue => error
        if JSON.parse(error.message)["code"] == 429 && @cached_queue_size
          return @cached_queue_size
        end
        raise error
      end
      
      # For backwards compatibility with the old method API.
      alias queue_size system_queue_size
    end
  end
end
