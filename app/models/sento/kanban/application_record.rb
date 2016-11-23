module Sento
  module Kanban
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
