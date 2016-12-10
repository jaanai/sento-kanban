// Select the first form field automatically
function selectFirstActiveInput() {
  setTimeout(function() {
    var firstField = $("form:not(.filter) :input:visible:enabled:first");
    if (firstField.length > 0)
      firstField.get(0).focus();
  }, 200);
}
