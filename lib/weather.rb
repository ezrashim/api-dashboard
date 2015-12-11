require "net/http"
require "json"

class Weather
  attr_reader :ip, :data

  def initialize(ip)
    @ip = ip
    @data = get_weather["current_observation"]
    @data = default_weather if get_weather.nil?
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
    @key = ENV["WUNDERGROUND_API_KEY"]
    URI("http://api.wunderground.com/api/#{@key}/conditions/q/MA/Boston.json")
  end

  def uri
    @key = ENV["WUNDERGROUND_API_KEY"]
    URI("http://api.wunderground.com/api/#{@key}/conditions/q/autoip.json")
  end
end
