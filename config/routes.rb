Rails.application.routes.draw do
  get 'project/index'
  resources :expense, only: [:index, :show]
  get 'company/index'
  get 'home/index'
  get 'authentication/index'

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
