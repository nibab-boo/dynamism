import { Controller } from "stimulus"
import {csrfToken} from '@rails/ujs'
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

  save() {
    console.log("saved");
    this.titleTarget.disabled = true;
    const formData = new FormData();
    if ( this.titleTarget.dataset.old !== this.titleTarget.value ) {

      formData.append("album['title']", this.titleTarget.value)
      console.log( JSON.stringify(formData));
      console.log(`/albums/${this.titleTarget.id}`);
      fetch(`/albums/${this.titleTarget.id}`, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken()
          },
          body: JSON.stringify({ album: { title: this.titleTarget.value } })
        }).then(response => response.json())
          .then(data => {
            this.titleTarget.value = data.title;
          });
  }
  }
}
