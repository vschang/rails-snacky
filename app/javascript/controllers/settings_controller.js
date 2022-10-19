import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="settings"
export default class extends Controller {
  connect() {
    console.log('settings connected!')
  }

  open = () => {
    console.log('opening settings')
    let settingsDiv = document.querySelector('.delete-back-modal-background')
    settingsDiv.style.visibility="visible";
  }

  close = () => {
    console.log('closing settings')
    let settingsDiv = document.querySelector('.delete-back-modal-background')
    settingsDiv.style.visibility="hidden";
  }
}
