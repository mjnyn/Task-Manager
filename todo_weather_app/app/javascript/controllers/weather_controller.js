import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["temperature", "sunrise", "sunset"];
  
  connect() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => this.fetchWeatherData(position.coords.latitude, position.coords.longitude),
        () => this.fetchWeatherData(),
        { timeout: 5000 } // when running in docker, location determination seems to sometimes hang
      )
    } else {
      this.fetchWeatherData()
    }
  }

  async fetchWeatherData(lat=-33.91823523952793, lon=18.42535499728242) {
    try {
      const weatherResponse = await fetch(`/weather?lat=${lat}&lon=${lon}`);
      const weatherData = await weatherResponse.json();

      if (!weatherResponse.ok) {
        console.log("Weather API failed", error);
        this.temperatureTarget.textContent = "N/A"
        this.sunriseTarget.textContent = "N/A"
        this.sunsetTarget.textContent = "N/A"
      }
  
      this.temperatureTarget.textContent = `${weatherData.temp_c}°C`
      this.sunriseTarget.textContent = `${weatherData.sunrise}`
      this.sunsetTarget.textContent = `${weatherData.sunset}`
    } catch (error) {
      console.log("Weather API failed", error);
      this.temperatureTarget.textContent = "N/A"
      this.sunriseTarget.textContent = "N/A"
      this.sunsetTarget.textContent = "N/A"
    }
    
  }
}
