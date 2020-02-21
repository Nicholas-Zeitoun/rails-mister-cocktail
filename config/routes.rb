Rails.application.routes.draw do
  root to: 'cocktails#index'
  get 'home', to: 'pages#home'
  resources :doses, only: [:destroy]

  delete "cocktailss/:id", to: "restaurants#destroy"

  resources :cocktails do
    resources :doses, only: [:new, :create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
