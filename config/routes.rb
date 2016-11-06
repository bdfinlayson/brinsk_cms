Rails.application.routes.draw do

  devise_for :users
  resources :contacts do
    resources :tasks, except: [:show]
    resources :notes
  end

  resources :projects do
    member do
      patch :complete
    end
  end
  resources :notes, except: [:show]
  resources :tasks, except: [:show]

  root "contacts#index"

end
