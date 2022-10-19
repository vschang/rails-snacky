import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="settings-profile"
export default class extends Controller {
  connect() {
    console.log('profile connected!')
  }

  open = () => {
    console.log('opening settings')
    let settingsDiv = document.getElementById('settings-background')
    console.log(settingsDiv)
    settingsDiv.style.visibility="visible";
  }

  close = () => {
    console.log('closing settings')
    let settingsDiv = document.getElementById('settings-background')
    settingsDiv.style.visibility="hidden";
  }
}
