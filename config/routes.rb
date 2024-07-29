Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  #   passwords: 'users/passwords',
  #   confirmations: 'users/confirmations',
  #   unlocks: 'users/unlocks'
  }
  
  resources :employees
  resources :users do
    resources :candidates
  end
  root to: 'users#index'
end
