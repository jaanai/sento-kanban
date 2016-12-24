module Sento
  module Kanban
    class ApplicationMailer < ActionMailer::Base
      default from: 'Sento.io <no-reply@sento.io>'
      layout 'mailer'

      helper Sento::Kanban::ApplicationHelper
    end
  end
end
