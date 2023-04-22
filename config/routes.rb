Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'posts#index'
  root to: "posts#index"
  resources :users, only: [:show, :update, :edit] do
    resources :dog_profiles, only: [:new, :create, :update, :edit, :destroy]
    member do
      get 'post_picture'
    end
  end
  resources :posts do
    member do
      get 'download'
    end
  end
  resources :rooms, only: [:index, :create, :destroy, :show] do
    member do
      post 'add_user'
    end
    resources :messages, only: [:index, :create]
  end
end
