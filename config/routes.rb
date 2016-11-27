Sento::Kanban::Engine.routes.draw do
  resources :cards

  root to: 'cards#index'
end
