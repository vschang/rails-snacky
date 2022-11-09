import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pic-preview"
export default class extends Controller {
  static targets = ["preview", "preview-post", "file"];

  connect() {
    console.log('pic preview!')
  }

  display = () => {
    let file = this.element.children[2].children[0].children[1].files[0]
    document.getElementById('preview').src = window.URL.createObjectURL(file)
  }

  displayPostPic = () => {
    let files = this.fileTarget.files

    for (let i = 0; i < files.length; i++) {
      document.getElementById('preview-pics').innerHTML += `<img src="${window.URL.createObjectURL(files[i])}" class="preview-image">`
    }
  }
}
