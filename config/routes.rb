Rails.application.routes.draw do
  get 'messages/index'
  devise_for :users
  get '/users', to: 'posts#index'
  root to: "posts#index"
  resources :posts do
    member do
      get 'download'
    end
  end
  resources :rooms, only: [:new, :create]
end
