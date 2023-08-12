Rails.application.routes.draw do
  get 'group/new'
  get 'group/create'
  get 'group/show'
  get 'group/edit'
  get 'group/update'
  get 'group/destroy'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
