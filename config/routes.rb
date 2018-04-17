Rails.application.routes.draw do
  resources :problems
  get 'home/index'

  devise_for :users
  root 'home#index'
  get 'editor/:id/:lid' => 'home#editor', :as => :editor
  get 'challanges/' => 'problems#index_home', :as => :solve
  get 'languages/:id' => 'home#language', :as => :language
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
