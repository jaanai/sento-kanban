module Sento
  module Kanban
    class BuildSearchAutocompleteResults
      include Interactor::Organizer

      organize Search::ModelsAutocomplete, Search::SuggestToInvite
    end
  end
end
