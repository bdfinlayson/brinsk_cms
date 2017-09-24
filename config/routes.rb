Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  resources :contacts do
    member do
      post :send_status_update_request
    end
    resources :notes
  end
  resources :goals

  resources :reports, only: [:create, :index, :show]

  resources :retrospectives, only: [:new, :create, :index] do
    collection do
      get :thank_you
      get :error
    end
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
