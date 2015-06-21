Rails.application.routes.draw do

  devise_for :users
  resources :contacts do
    resources :projects do
      member do
        patch :complete
      end
      resources :stages do
        resources :tasks do
          member do
            patch :complete
          end
        end
      end
      resources :notes
    end
    resources :notes, except: [:show]
    resources :tasks, except: [:show] do
      member do
        patch :complete
      end
    end
  end

  resources :projects
  resources :notes, except: [:show]
  resources :tasks, except: [:show]

  root "contacts#index"

end
