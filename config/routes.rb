Rails.application.routes.draw do

  get 'contacts/index'
  resources :notes, only: [:create, :update, :destroy]

  devise_for :users

  root "contacts#index"

end
