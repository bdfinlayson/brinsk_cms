Rails.application.routes.draw do

  get 'retrospectives/new'

  get 'retrospectives/create'

  get 'retrospectives/index'

  devise_for :users
  resources :contacts do
    resources :notes
  end

  resources :tags, only: [:index, :edit, :create, :update, :destroy]

  resources :projects do
    member do
      patch :complete
    end
  end
  resources :notes, except: [:show]
  resources :tasks, except: [:show] do
    collection do
      patch :update_batch
      patch :archive_batch
    end
  end

  root "contacts#index"

end
