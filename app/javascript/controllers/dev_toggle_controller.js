import { Controller } from "stimulus"

export default class extends Controller {
  // static targets = [ "input" ]

  connect() {
    console.log("connected")
  }

  toggle() {
    // console.log("toggle")
    fetch("/user/toggle")
  }


}