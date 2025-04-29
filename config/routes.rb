Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :comments
      resources :books
      resources :users

      get "up" => "rails/health#show", as: :rails_health_check
    end
  end
 
end
