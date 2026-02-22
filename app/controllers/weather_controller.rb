require "net/http"
require "uri"
require "json"

class WeatherController < ApplicationController
  def weather
    lat = params[:lat]
    lon = params[:lon]
    api_param = "#{lat},#{lon}"
    api_param_backup = "Cape Town"
    api_key = Rails.application.credentials.weather_api_key
    current_res = nil
    astronomy_res = nil

    begin
      current_res = fetch_cached_data("temp", "http://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{api_param}")
      astronomy_res = fetch_cached_data("astro", "http://api.weatherapi.com/v1/astronomy.json?key=#{api_key}&q=#{api_param}")
    rescue
      # I ran into at some point "{\"error\":{\"code\":1006,\"message\":\"No matching location found.\"}}"
      # Thus falling back to a second param
      current_res = fetch_cached_data("temp", "http://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{api_param_backup}")
      astronomy_res = fetch_cached_data("astro", "http://api.weatherapi.com/v1/astronomy.json?key=#{api_key}&q=#{api_param_backup}")
    end

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
