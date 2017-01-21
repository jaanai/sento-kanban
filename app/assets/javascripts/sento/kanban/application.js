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
//= require_tree ./floating_menu
//= require_tree ./helpers
//= require_tree ./search

function loadPageContentAjax() {
  $.ajax({ url: document.URL, method: 'GET', dataType: 'script' });
}

// unobtrusive_flash
UnobtrusiveFlash.flashOptions['timeout'] = 4000;

$(document).on('ready page:load', function () {
  SentoKanbanFloatingMenu();
  applyPerfectScrollbar();
});
