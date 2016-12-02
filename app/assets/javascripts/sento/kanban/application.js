//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require perfect-scrollbar
//= require dragula
//= require modal-responder
//= require pace/pace

//= require sento/kanban/kanban

//= require_tree ./boards

function loadPageContentAjax() {
  $.ajax({ url: document.URL, method: 'GET', dataType: 'script' });
}
