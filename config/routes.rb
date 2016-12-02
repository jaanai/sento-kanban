Sento::Kanban::Engine.routes.draw do
  resources :boards do
    resources :columns do
      resources :cards
    end
  end

  root to: 'boards#index'
end
