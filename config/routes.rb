Sento::Kanban::Engine.routes.draw do
  resources :boards do
    resources :columns do
      member do
        get :delete
      end
      resources :cards, only: [:new, :create]
    end
    resources :cards, only: :update
    resources :users do
      post :add
    end
  end
  resources :cards, except: [:index, :new, :create, :edit] do
    resources :comments
    resources :watchers
    resources :assignees
    member do
      get :edit_title, path: 'edit/title'
      get :edit_description, path: 'edit/description'
      patch :archive
    end
  end

  resources :users do
    collection do
      get 'ask-username', to: 'users#ask_username'
      get 'check-username', to: 'users#check_username'
      get :invite
    end
  end

  resource :search do
    collection do
      get :autocomplete
    end
  end

  root to: 'boards#index'
end
