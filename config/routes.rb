Rails.application.routes.draw do

  devise_for :users
  resources :contacts do
    resources :notes
  end

  resources :notes, except: [:show]

  root "contacts#index"

end
