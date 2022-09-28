import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gallery4"
export default class extends Controller {

  variable = "something"
  static targets = ["image"];
  static values = {index: Number};
  connect() {
    console.log('gallery connected~')
  }

  next() {
    const slideshow = this.element.querySelector('.slideshow-div-user-profile').children
    if (this.indexValue > (slideshow.length-2)) {
      this.indexValue = 0
    } else {
      this.indexValue++
    }
    console.log(this.indexValue)
    console.log(slideshow)
  };

  prev() {
    const slideshow = this.element.querySelector('.slideshow-div-user-profile').children
    if (this.indexValue < 1) {
      this.indexValue = (slideshow.length-1)
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
  }
}