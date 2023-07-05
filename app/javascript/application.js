// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import '@hotwired/turbo-rails';
// import 'controllers';

function getForm(id) {
  return document.getElementById(id);
}

function formActions(event) {
  let currentElement = event.target;

  switch (currentElement.id) {
    case 'login-action':
    case 'signup-action':
      getForm('new_user').submit();
      break;

    case 'category-action':
      getForm('new_category').submit();
      break;

    case 'transaction-action':
      getForm('new_transaction').submit();
      break;

    default:
      break;
  }
}

document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.action-trigger').forEach((item) => {
    item.addEventListener('click', (e) => {
      formActions(e);
    });
  });
});
