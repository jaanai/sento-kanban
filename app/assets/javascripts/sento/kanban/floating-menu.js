// Sento Kanban Floating menu
// This object hooks to the page and show/hide the sliding menu
var SentoKanbanFloatingMenu = {
  initialize : function() {
    this.openHook();
    this.closeHook();
  },

  openHook : function() {
    $('*[data-behavior="open-floating-menu"]').on('click', function() {
      SentoKanbanFloatingMenu.selector().addClass('show');
    });
  },

  closeHook : function() {
    $('*[data-behavior="close-floating-menu"]').on('click', function() {
      SentoKanbanFloatingMenu.selector().removeClass('show');
    });
  },

  selector : function() {
    return $('.floating-menu');
  }
}
