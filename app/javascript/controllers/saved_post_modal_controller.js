import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="saved-post-modal"
export default class extends Controller {
  connect() {
    console.log('SAVED POST')
  }

  open = () => {
    console.log('opening saved posts')
    let settingsDiv = document.getElementById('saved-background')
    console.log(settingsDiv)
    settingsDiv.style.visibility="visible";
  }

  close = () => {
    console.log('closing saved-post')
    let settingsDiv = document.getElementById('saved-background')
    settingsDiv.style.visibility="hidden";
  }
}
