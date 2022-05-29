import 'csrf-token'
import { Controller } from "stimulus"
import e from 'turbolinks';

export default class extends Controller {

  static targets = [ "title" ]
  connect() {
    console.log("connected");
  }

  enable() {
    this.titleTarget.disabled = false;
    this.titleTarget.focus();
    this.titleTarget.setSelectionRange(this.titleTarget.value.length, this.titleTarget.value.length)
  }

}
