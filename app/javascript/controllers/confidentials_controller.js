import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  eyeToggle(e) {
    if (this.inputTarget.type == "text") {
      this.inputTarget.type = "password";
      e.currentTarget.innerHTML = '<i class="fa-solid fa-eye-slash"></i>';
    } else {
      this.inputTarget.type = "text";
      e.currentTarget.innerHTML = '<i class="fa-solid fa-eye"></i>';
    }
  }

  clipboardCopy() {
    console.log("copying!");
  }
} 