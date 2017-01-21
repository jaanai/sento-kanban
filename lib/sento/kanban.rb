require 'slim-rails'
require 'bootstrap'
require 'dragula-rails'
require 'perfect-scrollbar-rails'
require 'modal-responder-rails'
require 'pace/rails'
require 'unobtrusive_flash'
require 'octicons_helper'
require 'interactor'
require 'ranked-model'
require 'searchkick'
require 'gemoji'
require 'tether-rails'
require 'chosen-rails'

module Sento
  module Kanban
    # Sento::Kanban.using_devise
    mattr_accessor :using_devise

    # Sento::Kanban.search_adapter
    mattr_accessor :search_adapter

    def self.configure
      yield self
    end
  end
end

require 'sento/kanban/engine'
