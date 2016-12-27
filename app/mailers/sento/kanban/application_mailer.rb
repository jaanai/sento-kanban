module Sento
  module Kanban
    class ApplicationMailer < ActionMailer::Base
      default from: 'Sento.io <no-reply@sento.io>'
      layout 'layouts/sento/kanban/mailer'

      helper Sento::Kanban::ApplicationHelper
      helper Sento::Kanban::MailerHelper
    end
  end
end
