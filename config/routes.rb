Rails.application.routes.draw do
  devise_for :users


resources :albums do
  member do
    delete :purge_image
  end
end

  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
