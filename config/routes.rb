Rails.application.routes.draw do
  resources :problems
  get 'home/index'

  devise_for :users
  root 'home#index'
  get 'home/solving'
  get 'challanges/' => 'problems#index_home', :as => :solve
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
