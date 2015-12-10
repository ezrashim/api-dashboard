require "./lib/geolocation"
require "./lib/weather"
require "./lib/news"
require "./lib/events"
require "sinatra/base"
require 'pry'

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do
    @ip = request.ip
    @geolocation = Geolocation.new(@ip)
    @weather = Weather.new(@ip)
    @events = Events.new(@ip)
    @news = News.new
    erb :dashboard
  end
end
