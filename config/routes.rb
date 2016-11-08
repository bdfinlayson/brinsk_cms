Rails.application.routes.draw do

  devise_for :users
  resources :contacts do
    resources :tasks, except: [:show]
    resources :notes
  end

  resources :tags, only: [:index, :edit, :update, :destroy]

  resources :projects do
    member do
      patch :complete
    end
  end
  resources :notes, except: [:show]
  resources :tasks, except: [:show] do
    collection do
      patch :update_batch
    end
  end

  root "contacts#index"

end
