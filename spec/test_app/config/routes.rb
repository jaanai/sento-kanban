Rails.application.routes.draw do
  mount Sento::Kanban::Engine => '/'
end
