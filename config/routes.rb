Sento::Kanban::Engine.routes.draw do
  resources :boards do
    resources :columns do
      member do
        get :delete
      end
      resources :cards, only: [:new, :create]
    end
    resources :cards, only: :update
  end
  resources :cards, except: [:index, :new, :create] do
    resources :comments
    member do
      patch :archive
    end
  end

  root to: 'boards#index'
end
