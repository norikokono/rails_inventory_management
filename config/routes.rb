Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    root 'welcome#home'
    get('/home', to: 'welcome#home')
    
    resources :users, ony: [:new, :create]
    resource :user, only: [:edit, :update]
    resource :session, only: [:new, :create, :destroy]

    resources :products do
      resources :reviews, only: [:create, :destroy] 
  end
end