Rails.application.routes.draw do
  devise_for :users, path: '',
            path_names: {
              sign_in: 'login',
              sign_out: 'logout',
              # password: 'secret',
              confirmation: 'verification',
              unlock: 'unblock',
              # registration: 'register',
              sign_up: 'signup'
             },
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations',
              confirmations: 'users/confirmations',
              unlocks: 'users/unlocks',
              passwords: 'users/passwords'
            }

  get "up" => "rails/health#show", as: :rails_health_check

  root "welcome#index"

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :employer do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :freelancer do
    get 'dashboard', to: 'dashboard#index'
  end

  # match '*path', to: 'application#route_not_found', via: :all

end
