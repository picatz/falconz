$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'falconz'
require 'pry'

client = Falconz::Client.new


binding.pry
