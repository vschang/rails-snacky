import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="multistep-form"
export default class extends Controller {
  static targets = [ "step" ]
  static values = {index: Number, page: String};

  connect() {
    console.log('form contorller connected')
  }

  next = () => {
    // const stepsNext = document.getElementsByClassName('post-step-next')
    // console.log(this.element.children)
    if (this.indexValue > 2){
      this.indexValue === 3
    } else {
      this.indexValue++
    }
  }

  back = () => {
    // const stepsBack = document.getElementsByClassName('post-step-back')
    // console.log(stepsBack)
    if (this.indexValue < 1){
      this.indexValue === 0
    } else {
      this.indexValue--
    }
    console.log(this.indexValue)
  }

  indexValueChanged() {
    this.showCurrentStep()
  };

  showCurrentStep() {
    this.stepTargets.forEach((element, index) => (
    element.hidden = index != this.indexValue
    ))
  }
}
