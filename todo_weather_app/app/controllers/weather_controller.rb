require "net/http"
require "uri"
require "json"

class WeatherController < ApplicationController
  # Makes the rest calls to the weather API. Placed inside the controller to ensure api key is hidden
  def weather
    lat = params[:lat] || -33.91823523952793
    lon = params[:lon] || 18.42535499728242
    api_key = Rails.application.credentials.weather_api_key

    current_res = fetch_cached_data("temp", "http://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{lat},#{lon}")
    astronomy_res = fetch_cached_data("astro", "http://api.weatherapi.com/v1/astronomy.json?key=#{api_key}&q=#{lat},#{lon}")

    temp_c = JSON.parse(current_res)["current"]["temp_c"]
    sunrise = JSON.parse(astronomy_res)["astronomy"]["astro"]["sunrise"]
    sunset = JSON.parse(astronomy_res)["astronomy"]["astro"]["sunset"]

    render json: { temp_c: temp_c, sunrise: sunrise, sunset: sunset }
  end

  def fetch_cached_data(data_name, url)
    cache_key = "WEATHER_DATA_#{data_name}"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      uri = URI(url)
      Net::HTTP.get(uri)
    end
  end
end
