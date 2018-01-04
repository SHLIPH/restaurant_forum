Rails.application.routes.draw do
  devise_for :users

  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    collection do
      # 瀏覽所有餐廳的最新動態
      # GET restaurants/feeds
      get :feeds

      #十大人氣餐廳
      get :ranking
    end

    member do
      get :dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end
  end
  resources :categories, only: :show
  resources :users, only: [:show, :edit, :update]
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end
