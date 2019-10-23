Rails.application.routes.draw do
  resources :user, only: [:index, :show]
  resources :user do
    get 'export', on: :member
  end
  get 'project/index' 
  resources :expense, only: [:index, :show]
  get 'company/index'
  get 'home/index'
  get 'authentication/index'

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
