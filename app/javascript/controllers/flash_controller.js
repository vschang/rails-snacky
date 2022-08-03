import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    console.log("Flash controller connected")
  }
  
  hide = () => {
    console.log('closing the flash')
    this.element.classList.add("fade-out")
  }
}
