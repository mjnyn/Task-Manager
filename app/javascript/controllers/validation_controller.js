import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit", "input"]

  connect() {}

  check() {
    // TODO meant to check if text field populated if not disable form button
    const value = this.inputTarget.value.trim() === "";
    this.submitTarget.disabled = value;
  }

  reset() {
    this.element.reset();
  }
}
