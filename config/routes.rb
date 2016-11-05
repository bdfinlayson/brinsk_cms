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
  end

  resources :projects do
    member do
      patch :complete
      post :email_contact
    end
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
