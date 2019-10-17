Rails.application.routes.draw do
  get 'expense/index'
  get 'company/index'
  get 'home/index'
  get 'authentication/index'

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
