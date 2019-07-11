Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :locations, only: [:index, :create, :show]
    end
  end
  mount Resque::Server.new, :at => "/resque"

end
