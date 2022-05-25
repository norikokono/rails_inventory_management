Rails.application.routes.draw do
 
  root 'welcome#home'
  get('/home', to: 'welcome#home')
  
  # Session Routes
  resource :session, only: [:new, :create, :destroy]

  # RESTful Product Routes
  #  get '/products/new', to: 'products#new', as: :new_product
  #  post '/products', to: 'products#create'
  #  get '/products/:id', to: 'products#show', as: :product
  #  get '/products', to: 'products#index'
  delete '/products/:id', to: 'products#destroy'
  #  get '/products/:id/edit', to: 'products#edit', as: :edit_product
  #  patch '/products/:id', to: 'products#update'
  delete '/reviews/:id' => 'reviews#destroy'
  
  # https://stackoverflow.com/questions/71882837/redirect-in-destroy-action-not-working-properly
  get 'session' => :destroy, to: 'sessions#destroy'

  resources :products do
    resources :reviews, shallow: :true, only: [:create, :destroy] do
    end
  end

  resources :users, only: [:new, :create]
end
