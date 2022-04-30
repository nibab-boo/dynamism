import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    console.log("connected")
  }

  toggle(e) {
    const crsfToken = document.querySelector('[name="csrf-token"]');
    fetch("/toggle", {
      method: "POST",
      headers: {'Content-Type': 'application/json', 'X-CSRF-Token': crsfToken.content},
      body: JSON.stringify({ test: e.currentTarget.checked })
    })
    .then(response => response.json())
    .then(data =>{
      e.target.checked = data.test;
    }).catch((error) => {
      console.error('Error:', error);
    })
  }


}
