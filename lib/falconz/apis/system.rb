module Falconz
  module APIs
    module System
      def system_heartbeat(wait = 15)
        return get_request("/system/heartbeat") unless block_given?
        while true
          yield get_request("/system/heartbeat")
          sleep wait
        end
      end

      def number_of_seconds_since_last_update
        system_heartbeat["number_of_seconds_since_last_update"]
      end

      def total_submissions_in_system
        get_request("/system/total-submissions")["value"]
      end
      
      def in_progress
        return get_request("/system/in-progress")["values"] unless block_given?
        get_request("/system/in-progress")["values"].each do |value| 
          hash, env = value.split(":")
          yield hash, env 
        end
      end
      
      def backend
        get_request("/system/backend")
      end
      
      def environments
        return get_request("/system/environments") unless block_given?
        get_request("/system/environments").each do |enviroment|
          yield enviroment
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

      def enviroment_ids(refresh: false)
        if refresh or @enviroment_ids.nil?
          @enviroment_ids = environments.map { |env| env["id"] } 
        end
        return @enviroment_ids unless block_given?
        @environment_ids.each { |env| yield id }
      end

      def enviroments_busy_percentages
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

      def environment_windows?(id)
        env = find_environment_by_id(id)
        return nil if env.nil?
        return true if env["architecture"] == "WINDOWS"
        false
      end
      
      def environment_linux?(id)
        env = find_environment_by_id(id)
        return nil if env.nil?
        return true if env["architecture"] == "LINUX"
        false
      end

      def system_state
        get_request("/system/state")
      end

      def system_version
        get_request("/system/version")
      end
      
      def queue_size
        get_request("/system/queue-size")["value"]
      end
    end
  end
end
