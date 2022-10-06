import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pic-preview"
export default class extends Controller {
  static targets = ["preview"];

  connect() {
    console.log('pic preview!')
  }

  display = () => {
    // let preview = document.getElementById('preview').src
    let file = this.element.children[2].children[0].children[1].files[0]
    document.getElementById('preview').src = window.URL.createObjectURL(file)
  }
}
