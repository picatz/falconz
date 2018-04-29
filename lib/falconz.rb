require "httparty"
require "falconz/client"
require "falconz/version"

# Falcon Sandbox has a powerful and simple API 
# that can be used to submit files/URLs for analysis, 
# pull report data, but also perform advanced search 
# queries. The API is open and free to the entire 
# IT-security community.
module Falconz
  def self.client
    Client
  end

  def self.response_is_ok?(resp)
    return false unless resp.respond_to?(:has_key?)
    return false unless resp.has_key? "status"
    return true if resp["status"].match?("ok")
    return false
  end
end
