Rails.application.routes.draw do
  root 'books#index'

  resources :categories do
    member do
      get 'delete', to: 'categories#delete'
    end
    collection do
      get 'search', to: 'categories#search'
    end
  end

  resources :books do
    collection do
      get 'show_all', to: 'books#show_all'
    end
    member do
      get 'delete', to: 'books#delete'
    end
  end

  get 'admins/login', to: 'admins#login'
  post 'admins/login', to: 'admins#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
