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
end
