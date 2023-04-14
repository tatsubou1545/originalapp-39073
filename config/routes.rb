Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'posts#index'
  root to: "posts#index"
  resources :posts do
    member do
      get 'download'
    end
  end
end
