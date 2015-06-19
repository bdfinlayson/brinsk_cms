Rails.application.routes.draw do
  devise_for :users
  resources :contacts do
    resources :notes
  end

  root "contacts#index"


end
