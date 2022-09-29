import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list-tag"
export default class extends Controller {
  static targets = ["tags", "form"]

  connect() {
    // console.log(this.element)
    // console.log(this.itemsTarget)
    // console.log(this.formTarget)
    console.log("tag controller connected to", this.element.getAttribute("data-component"))
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
      if (data.inserted_tag) {
        this.tagsTarget.insertAdjacentHTML("beforeend", data.inserted_tag)
      }else {
        let alert = document.querySelector('.alert');
        alert.querySelector('.alert-msg').innerText = "tag has already been added"
        alert.classList.remove('invisible');
        alert.classList.remove('hide-animation');
        setTimeout(() => {
          alert.classList.add('hide-animation');
        }, 50);
      }
      // this.formTarget.outerHTML = data.form
    })

  }
}
