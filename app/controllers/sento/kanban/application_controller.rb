require 'ffaker'

module Sento
  module Kanban
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception
    end
  end
end
