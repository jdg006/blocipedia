Rails.application.routes.draw do
  resources :charges, only: [:new, :create]
  
  resources :wikis

  devise_for :users
  
  resources :collaborators
  
  post 'welcome/downgrade'
  
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
