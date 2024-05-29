import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!")
  }

  toggle(event) {
    event.preventDefault();
    this.element.classList.toggle("hidden");
  }

  delete(event) {
    event.preventDefault();
    const id = document.getElementById("popup");
    id.classList.toggle("hidden");
  }
}
