module Falconz
  module APIs
    module System
      def system_heartbeat(wait = 15, **options)
        return get_request("/system/heartbeat", options) unless block_given?
        while true
          yield get_request("/system/heartbeat", options)
          sleep wait
        end
      end

      def number_of_seconds_since_last_update
        system_heartbeat["number_of_seconds_since_last_update"]
      end

      def total_submissions_in_system(**options)
        get_request("/system/total-submissions", options)["value"]
      end
      
      def in_progress(**options)
        return get_request("/system/in-progress", options)["values"] unless block_given?
        get_request("/system/in-progress", options)["values"].each do |value| 
          hash, env = value.split(":")
          yield hash, env 
        end
      end
      
      def backend(**options)
        get_request("/system/backend", options)
      end
      
      def environments(**options)
        return get_request("/system/environments", options) unless block_given?
        get_request("/system/environments", options).each do |enviroment|
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

      def enviroment_windows?(id)
        env = find_environment_by_id(id)
        return nil if env.nil?
        return true if env["architecture"] == "WINDOWS"
        false
      end
      
      def enviroment_linux?(id)
        env = find_environment_by_id(id)
        return nil if env.nil?
        return true if env["architecture"] == "LINUX"
        false
      end

      def system_state(**options)
        get_request("/system/state", options)
      end

      def system_version(**options)
        get_request("/system/version", options)
      end
      
      def queue_size(**options)
        get_request("/system/queue-size", options)["value"]
      end
    end
  end
end
