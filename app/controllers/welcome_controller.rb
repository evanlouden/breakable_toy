class WelcomeController < ApplicationController

  def index
    hourly_weather = HTTParty.get('http://api.wunderground.com/api/4df2692f4067c5b7/hourly/q/MA/Boston.json')
    @weather_data = []
    4.times do |n|
      @weather_data << {
        temp: hourly_weather["hourly_forecast"][n]["temp"]["english"],
        icon: hourly_weather["hourly_forecast"][n]["icon_url"],
        pop: hourly_weather["hourly_forecast"][n]["pop"]
      }
    end
  end
end
