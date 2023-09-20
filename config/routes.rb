Rails.application.routes.draw do
  devise_for :users
  authenticate do
    # post 'companies/search', to: 'companies#search'
    # get 'companies/search', to: 'companies#search'
    # get 'companies/export', to: 'companies#export', format: %w[csv email_list]
    # post 'companies/export', to: 'companies#export', format: %w[txt]
    resources :companies do
      resources :addresses
      resources :contacts
      collection do
        get 'search'
        post 'search'
        get 'export', to: 'companies#export', format: %w[csv email_list]
        post 'export', to: 'companies#export', format: %w[txt]
      end
    end

    resources :plans do
      get 'search', on: :collection
      get 'new_on_date/:date', to: 'plans#new_on_date', on: :collection
      get 'new_for_company/:company_id', to: 'plans#new_for_company', on: :collection
      post 'status/:id', to: 'plans#set_status', on: :collection
      post 'date/:id', to: 'plans#set_date', on: :collection
    end
    resources :addresses do
      get 'search', on: :collection
      post 'search', on: :collection
      get 'all', on: :collection
    end

    resources :contacts do
      collection do
        get :search, :all
        post :search
      end
    end

    root to: 'welcome#index'

    resources :users do
      collection do
        post 'search' => 'users#search'
        get 'search' => 'users#search'
      end
      member do
        post :create
        patch :update
        get :new, :index, :show
        delete :destroy
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
