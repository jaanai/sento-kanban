function applyPerfectScrollbar(options) {
  $("[data-behavior='scrollable']").each(function(element) {
    $(this).perfectScrollbar(options);
  });
}
