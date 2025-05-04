Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :comments
      resources :books
      resources :users

      get "up" => "rails/health#show", as: :rails_health_check
    end
  end
end
