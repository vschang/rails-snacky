import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
    this.#activate()
  }

  #activate = () => {
    if (this.element.querySelector("a").pathname === window.location.pathname) {
      this.element.classList.add("active")
    }
  }
}
