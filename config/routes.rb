Rails.application.routes.draw do

  devise_for :users
  # resources :contacts do
  #   resources :projects do
  #     member do
  #       patch :complete
  #     end
  #     resources :stages, except: [:show] do
  #       resources :tasks do
  #         member do
  #           patch :complete
  #         end
  #       end
  #     end
  #   end
  #   resources :notes, except: [:show]
  #   resources :tasks, except: [:show] do
  #     member do
  #       patch :complete
  #     end
  #   end
  # end
  #
  resources :contacts do
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

#   resources :projects do
#     resources :stages
#     resources :notes
#     resources :tasks do
#       member do
#         patch :complete
#       end
#     end
#   end

#   resources :stages do
#     resources :tasks do
#       member do
#         patch :complete
#       end
#     end
#   end

  resources :appointments
  resources :projects
  resources :stages, except: [:show]
  resources :notes, except: [:show]
  resources :tasks, except: [:show]

  root "contacts#index"

end
