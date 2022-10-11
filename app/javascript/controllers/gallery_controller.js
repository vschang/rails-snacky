import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery"

export default class extends Controller {
  static targets = ["image", "dot"];
  static values = {index: Number};
  connect() {
    console.log('gallery connected~')
  }

  next() {
    const images = document.getElementsByClassName('post-image')
    console.log(this.dotTargets)

    if (this.indexValue > (images.length-2)) {
      this.indexValue = 0
    } else {
      this.indexValue++
    }
    console.log(this.indexValue)
  };

  prev() {
    const images = document.getElementsByClassName('post-image')
    if (this.indexValue < 1) {
      this.indexValue = (images.length-1)
    } else {
      this.indexValue--
    }
    console.log(this.indexValue)
  };

  indexValueChanged() {
    this.showCurrentImage()
  };

  showCurrentImage() {
    this.imageTargets.forEach((element, index) => (
      element.hidden = index != this.indexValue
    ))
    if (this.dotTargets.length === 0 ) {
      console.log("no dots")
    } else {
      for (let i = 0; i < this.dotTargets.length; i++) {
        this.dotTargets[i].className = this.dotTargets[i].className.replace("dot-active", "");
      }
      this.dotTargets[this.indexValue].className += "dot-active";
    }
  }

}
