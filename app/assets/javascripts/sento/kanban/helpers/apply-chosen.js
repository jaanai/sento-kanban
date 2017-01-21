function applyChosen() {
  $.each($('select[data-chosen="true"]'), function(index, object) {
    $(object).chosen({
      allow_single_deselect: true,
      no_results_text: $(object).data('chosen-no-results') || 'No results matched',
      disable_search_threshold: 10,
      width: $(object).data('chosen-width') || '200px'
    });
  });
}
