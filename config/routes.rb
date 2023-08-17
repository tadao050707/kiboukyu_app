Rails.application.routes.draw do
  get 'sesired_holidays/new'
  get 'sesired_holidays/create'
  get 'sesired_holidays/destroy'
  unauthenticated do
    as :user do
      root :to => 'devise/sessions#new'
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show]

  resources :groups, only: %i[new create show edit update destroy] do
    patch :change_owner, path: '/:user_id/owners/'
    patch :invalid, path: '/invalids/'
  end
  resources :groupings, only: %i[index create update destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
