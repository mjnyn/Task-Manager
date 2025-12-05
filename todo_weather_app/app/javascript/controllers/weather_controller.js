import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {
  static targets = ["temperature", "sunrise", "sunset"];
  
  connect() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => this.fetchWeatherData(position.coords.latitude, position.coords.longitude),
        () => this.fetchWeatherData()
      )
    } else {
      this.fetchWeatherData()
    }
  }

  async fetchWeatherData(lat, lon) {
    try {
      const weatherResponse = await fetch(`/weather?lat=${lat}&lon=${lon}`);
      const weatherData = await weatherResponse.json();

      if (!weatherResponse.ok) {
        this.temperatureTarget.textContent = "N/A"
        this.sunriseTarget.textContent = "N/A"
        this.sunsetTarget.textContent = "N/A"
      }
  
      this.temperatureTarget.textContent = `${weatherData.temp_c}°C`
      this.sunriseTarget.textContent = `${weatherData.sunrise}`
      this.sunsetTarget.textContent = `${weatherData.sunset}`
    } catch (error) {
      this.temperatureTarget.textContent = "N/A"
      this.sunriseTarget.textContent = "N/A"
      this.sunsetTarget.textContent = "N/A"
    }
    
  }
}
