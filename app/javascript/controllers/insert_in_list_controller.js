import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["items", "form"]
  static values = { position: String }

  connect() {
    // console.log(this.element)
    // console.log(this.itemsTarget)
    // console.log(this.formTarget)
    console.log("connected to", this.element.getAttribute("data-component"))
  }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      if (data.inserted_item) {
        this.itemsTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
      }
      this.formTarget.outerHTML = data.form
    })
    // .catch((e)=>{
    //   let alert = document.querySelector('.alert');
    //   alert.querySelector('.alert-msg').innerText = "tag already been added"
    //   alert.classList.remove('invisible');
    //   alert.classList.remove('hide-animation');
    //   setTimeout(() => {
    //     alert.classList.add('hide-animation');
    //   }, 50);

    // })
  }
}
