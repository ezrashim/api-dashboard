require "./lib/geolocation"
require "./lib/weather"
require "sinatra/base"
require 'pry'

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do
    @ip = request.ip
    @geolocation = Geolocation.new(@ip)
    @weather = Weather.new(@ip)
    erb :dashboard
  end
end
