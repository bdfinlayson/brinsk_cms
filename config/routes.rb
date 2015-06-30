Rails.application.routes.draw do

  devise_for :users
  resources :contacts do
    member do
      post :email_contact
    end
    resources :projects do
      resources :notes, except: [:show]
      resources :stages do
        resources :tasks do
          member do
            patch :complete
          end
        end
      end
      member do
        patch :complete
      end
      resources :tasks, except: [:show] do
        member do
          patch :complete
        end
      end
    end
    resources :tasks, except: [:show] do
      member do
        patch :complete
      end
    end
    resources :notes
    resources :appointments
  end

  resources :appointments
  resources :projects do
    member do
      patch :complete
      post :email_contact
    end
    resources :appointments
  end
  resources :stages, except: [:show]
  resources :notes, except: [:show]
  resources :tasks, except: [:show] do
    member do
      patch :complete
    end
  end

  root "contacts#index"

end
