Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  #   passwords: 'users/passwords',
  #   confirmations: 'users/confirmations',
  #   unlocks: 'users/unlocks'
  }

  resources :employees do
    member do
      get 'show_interview'
    end
  end
  resources :users do
    resources :candidates do
      collection { post :import }
    end
    resources :interviews
  end
  root to: 'users#index'
end
