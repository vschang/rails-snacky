import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    console.log("Flash controller connected")
  }

  hide = () => {
    console.log('closing the flash')

    this.element.classList.remove("fade-out")
    this.element.classList.remove("hide-animation")

    setTimeout(() => {
      this.element.classList.add("fade-out")
    }, 50);
  }
}
