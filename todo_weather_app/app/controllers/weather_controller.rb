require "net/http"
require "uri"
require "json"

class WeatherController < ApplicationController
  # Makes the rest calls to the weather API. Placed inside the controller to ensure api key is hidden
  def weather
    lat = params[:lat] || -33.91823523952793
    lon = params[:lon] || 18.42535499728242
    api_key = Rails.application.credentials.weather_api_key

    current_uri = URI("http://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{lat},#{lon}")
    astronomy_uri = URI("http://api.weatherapi.com/v1/astronomy.json?key=#{api_key}&q=#{lat},#{lon}")

    current_res = Net::HTTP.get(current_uri)
    astronomy_res = Net::HTTP.get(astronomy_uri)
    temp_c = JSON.parse(current_res)["current"]["temp_c"]
    sunrise = JSON.parse(astronomy_res)["astronomy"]["astro"]["sunrise"]
    sunset = JSON.parse(astronomy_res)["astronomy"]["astro"]["sunset"]

    render json: { temp_c: temp_c, sunrise: sunrise, sunset: sunset }
  end
end
