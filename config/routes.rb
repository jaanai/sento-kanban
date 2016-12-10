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
  resources :cards, except: [:index, :new, :create, :edit] do
    resources :comments
    member do
      get :edit_title, path: 'edit/title'
      get :edit_description, path: 'edit/description'
      patch :archive
    end
  end

  root to: 'boards#index'
end
