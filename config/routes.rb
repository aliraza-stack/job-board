Rails.application.routes.draw do

  devise_for :users, path: '',
            path_names: {
              sign_in: 'login',
              sign_out: 'logout',
              password: 'secret',
              confirmation: 'verification',
              unlock: 'unblock',
              registration: 'register',
              sign_up: 'signup'
             },
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations',
            }

  get "up" => "rails/health#show", as: :rails_health_check

  root "welcome#index"
end
