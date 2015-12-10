require "net/http"
require "json"
require 'pry'

class Story
  attr_reader :title, :thumbnail, :abstract, :url
  def initialize(title, thumbnail, abstract, url)
    @title = title
    @thumbnail = thumbnail
    @abstract = abstract
    @url = url
  end
end


class News
attr_reader :data
  def initialize(section = "home")
      @key = ENV["NYTIMES_API_KEY"]
      @section = section
      @data = get_news["results"]
  end

  def display
    @articles = Array.new
    data.map do |datum|
      title = datum["title"]
      if datum["multimedia"] == nil || datum["multimedia"][0] == nil
        thumbnail = "default"
      else
        thumbnail = datum["multimedia"][0]["url"]
      end

      abstract = datum["abstract"]
      url = datum["url"]
      @articles << Story.new(title, thumbnail, abstract, url)
    end
    return @articles
  end

  private
  def get_news
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def uri
    URI("http://api.nytimes.com/svc/topstories/v1/#{@section}.json?api-key=#{@key}
")
  end
end
