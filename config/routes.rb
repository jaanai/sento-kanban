Sento::Kanban::Engine.routes.draw do
  resources :boards do
    resources :columns
  end

  root to: 'boards#index'
end
