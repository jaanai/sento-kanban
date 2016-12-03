//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require perfect-scrollbar
//= require dragula
//= require modal-responder
//= require pace/pace
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap

//= require_tree ./boards

function loadPageContentAjax() {
  $.ajax({ url: document.URL, method: 'GET', dataType: 'script' });
}

// unobtrusive_flash
UnobtrusiveFlash.flashOptions['timeout'] = 4000;
