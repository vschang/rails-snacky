import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    console.log('modal connected')
  }

  open = () => {
    console.log('opening modal')
    let mapDiv = document.querySelector('.map-container-profile')
    document.querySelector('body').insertAdjacentHTML("afterbegin", `<div class="map-overlay remove-overlay"></div>`)
    mapDiv.style.visibility="visible";
  }

  close = () => {
    console.log('closing modal')
    let mapDiv = document.querySelector('.map-container-profile')
    let overlay = document.querySelector('.remove-overlay')
    console.log(overlay)
    mapDiv.style.visibility="hidden";
    overlay.remove()
  }
}
