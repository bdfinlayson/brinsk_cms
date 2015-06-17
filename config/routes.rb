Rails.application.routes.draw do

  get 'contacts/index'

  devise_for :users

  root "contacts#index"

end
