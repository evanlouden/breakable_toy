class WelcomeController < ApplicationController
  def index
    ip = request.remote_ip
    geolocation = HTTParty.get("http://freegeoip.net/json/#{ip}")
    binding.pry
    unless geolocation.nil?
      @state = geolocation["region_code"]
      @city = geolocation["city"]
      key = ENV["WUNDERGROUND_KEY"]
      hourly_weather = HTTParty.get("http://api.wunderground.com/api/#{key}/hourly/q/#{@state}/#{@city}.json")
      astronomy = HTTParty.get("http://api.wunderground.com/api/#{key}/astronomy/q/#{@state}/#{@city}.json")
      hour = astronomy["sun_phase"]["sunset"]["hour"]
      minute = astronomy["sun_phase"]["sunset"]["minute"]
      @sunset = Time.new.change(hour: hour, min: minute).strftime("%l:%M %p")
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
end
