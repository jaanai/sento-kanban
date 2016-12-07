require 'octicons_helper'
require 'interactor'
require 'sento/kanban/engine'

module Sento
  module Kanban
    mattr_accessor :using_devise

    def self.configure
      yield self
    end
  end
end
