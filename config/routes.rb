Rails.application.routes.draw do
  get 'groupings/create'
  get 'groupings/destroy'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show]

  resources :groups, only: %i[new create show edit update destroy]
  resources :groupings, only: %i[create update destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
