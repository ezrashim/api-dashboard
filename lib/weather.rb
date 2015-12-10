require "net/http"
require "json"

class Weather
  attr_reader :ip, :data

  def initialize(ip)
    @ip = ip
    @data = get_weather["current_observation"]
    @data = default_weather if get_weather.nil?
    @key = ENV["NYTIMES_API_KEY"]
  end

  def weather
    @data["weather"]
  end

  def temp
    @data["temperature_string"]
  end

  def get_weather
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def default_weather
    response = Net::HTTP.get_response(uri_d)
    JSON.parse(response.body)
  end

  def uri_d
    URI("http://api.wunderground.com/api/#{key}/conditions/q/MA/Boston.json")
  end

  def uri
    URI("http://api.wunderground.com/api/ed338a127312b2d4/conditions/q/autoip.json")
  end
end
