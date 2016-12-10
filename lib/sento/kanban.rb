require 'slim-rails'
require 'bootstrap'
require 'dragula-rails'
require 'perfect-scrollbar-rails'
require 'modal-responder-rails'
require 'pace/rails'
require 'unobtrusive_flash'
require 'octicons_helper'

module Sento
  module Kanban
    # Sento::Kanban.using_devise
    mattr_accessor :using_devise

    def self.configure
      yield self
    end
  end
end

require 'sento/kanban/engine'
