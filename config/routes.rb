Sento::Kanban::Engine.routes.draw do
  resources :boards do
    resources :columns do
      member do
        get :delete
      end
      resources :cards
    end
  end

  root to: 'boards#index'
end
