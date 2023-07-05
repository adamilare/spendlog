import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    document
      .getElementById('login-action')
      .addEventListener('click', formActions);
    document
      .getElementById('signup-action')
      .addEventListener('click', formActions);
  }

  formActions(event) {
    let currentElement = event.target;
    switch (currentElement.id) {
      case 'login-action':
        this.getForm('new-user').submit();
        break;

      default:
        break;
    }
  }

  getForm(id) {
    return document.getElementById(id);
  }
}
