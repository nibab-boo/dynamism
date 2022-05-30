import { Controller } from "stimulus"
import {csrfToken} from '@rails/ujs'
import e from 'turbolinks';

export default class extends Controller {

  static targets = [ "title", "photosForm", "delete" ]
  connect() {
    console.log("connected");
  }

  enable() {
    this.titleTarget.disabled = false;
    this.titleTarget.focus();
    this.titleTarget.setSelectionRange(this.titleTarget.value.length, this.titleTarget.value.length)
    this.deleteTarget.classList.remove("d-none")
  }

  save() {
    this.deleteTarget.classList.add("d-none")
    this.titleTarget.disabled = true;
    // SEND REQUEST ONLY IF CHANGED.
    if ( this.titleTarget.dataset.old !== this.titleTarget.value ) {
      fetch(`/albums/${this.titleTarget.id}`, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken()
          },
          body: JSON.stringify({ album: { title: this.titleTarget.value } })
        })
        .then(response => response.json())
        .then(data => {
          this.titleTarget.value = data.title;
        });
    }
  }

  toggleForm(e) {
    if (this.photosFormTarget.classList.contains("d-none")) {
      this.photosFormTarget.classList.add("d-inline-flex", "align-items-baseline");
      this.photosFormTarget.classList.remove("d-none");
      e.currentTarget.textContent = "Close"
    } else {
      this.photosFormTarget.classList.remove("d-inline-flex", "align-items-baseline");
      this.photosFormTarget.classList.add("d-none");
      e.currentTarget.textContent = "Add a photo";
    }
  }

  filesCounter(e) {
    const files = e.currentTarget.files;
    // REMOVES PREVIOUS BLURRED IMAGES
    document.querySelectorAll(".blurred").forEach(el => el.remove());
    e.currentTarget.previousElementSibling.textContent = `${files.length} FILES`
    const parentDiv = (e.currentTarget.closest(".album-box"));
    const imageBox = parentDiv.querySelector(".photo-card-box");
    
    Object.keys(files).forEach( function (key) {
      const reader = new FileReader();
      // FILE ON FINISHED LOADING
      reader.addEventListener("load", ()=> {
        const src = reader.result;
        const imgCard = `<div class="album-photo-card blurred">
                        <img src= ${src} />    
                      </div>`
        imageBox.insertAdjacentHTML("beforeend", imgCard);
      });
      // READ THE FILE
      reader.readAsDataURL(files[key]);
    });
  }
}
