Rails.application.routes.draw do
  mount Sento::Kanban::Engine => '/kanban'
end
