module Sento
  module Kanban
    #
    # This concern gather the user and invitation common methods
    #
    module MemberPresenter
      extend ActiveSupport::Concern

      #
      # Fetches the model fullname or username
      #
      # @return [String] User or Invitation fullname or username
      #
      def fullname_or_username
        @model.fullname || @model.username
      end
    end
  end
end
