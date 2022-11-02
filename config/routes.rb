Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :articles, only: :index
  # Defines the root path route ("/")
  root "articles#index"
end
