Rails.application.routes.draw do
  mount Sento::Kanban::Engine => "/sento-kanban"
end
