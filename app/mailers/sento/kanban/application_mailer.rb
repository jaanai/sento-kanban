module Sento
  module Kanban
    class ApplicationMailer < ActionMailer::Base
      default from: 'Sento.io <no-reply@sento.io>'
      layout 'mailer'
    end
  end
end
