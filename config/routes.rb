Rails.application.routes.draw do

  devise_for :users
  resources :contacts do
    resources :notes, except: [:show]
    resources :tasks, except: [:show] do
      member do
        patch :complete
      end
    end
  end

  resources :notes, except: [:show]
  resources :tasks, except: [:show]

  root "contacts#index"

end
