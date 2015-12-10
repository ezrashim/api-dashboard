require "net/http"
require "json"

class Events
  attr_reader :ip, :data, :city, :location, :state, :today, :data

  def initialize(ip)
    @ip = ip
    @location = Geolocation.new(ip)
    @city = @location.city
    @state = @location.state
    @today = Time.now.strftime("%Y-%m-%d")
    @data = get_events
  end

  def display
    @array = []
    data.each do |event|
     @array << "#{event["title"]} @ #{event["venue"]["name"]}"
    end
    @array
  end

  private
  def get_events
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["events"]
  end

  def uri
    URI("http://api.seatgeek.com/2/events?venue.city=#{city}&venue.state=#{state}&datetime_local.gte=#{today}")
  end
end
