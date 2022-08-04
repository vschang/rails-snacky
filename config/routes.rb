Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :edit, :update]

  resources :posts do
  # only: [:index, :new, :create, :edit, :update, :destroy] do
    get '/page/:page', action: :index, on: :collection
    resources :post_likes, only: [:create]
    resources :post_comments, only: [:new, :create, :index, :destroy]
    resources :post_tags, only: [:new, :create, :index, :destroy]
  end
  resources :post_likes, only: [:destory]

  get 'profile', to: 'pages#profile'
  get 'log_out', to: 'pages#destroy_sesh'
  get 'search', to: 'pages#search'
  get 'faq', to: 'pages#faq'
  get 'edit_prof_pic', to: 'pages#edit_prof_pic'
  patch 'update_prof_pic', to: 'pages#update_prof_pic'
  get '/posts' => "welcome#index", :as => :user_root
end
