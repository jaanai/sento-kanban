//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require perfect-scrollbar
//= require dragula
//= require modal-responder
//= require pace/pace
//= require sento/kanban/kanban

function loadPageContentAjax() {
  $.ajax({ url: document.URL, method: 'GET', dataType: 'script' });
}
