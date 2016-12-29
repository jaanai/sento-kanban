//= require jquery
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require perfect-scrollbar
//= require dragula
//= require modal-responder
//= require pace/pace
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require chosen-jquery

//= require_tree ./boards
//= require ./apply-bootstrap-popover
//= require ./apply-chosen
//= require ./apply-dragula
//= require ./apply-perfect-scrollbar
//= require ./select-first-input
//= require ./floating-menu
//= require ./sento-kanban-autocomplete
//= require ./sento-kanban-autocomplete-templates

function loadPageContentAjax() {
  $.ajax({ url: document.URL, method: 'GET', dataType: 'script' });
}

// unobtrusive_flash
UnobtrusiveFlash.flashOptions['timeout'] = 4000;

$(document).on('ready page:load', function () {
  SentoKanbanFloatingMenu();
  applyPerfectScrollbar();
});
