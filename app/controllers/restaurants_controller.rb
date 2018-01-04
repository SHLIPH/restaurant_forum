class RestaurantsController < ApplicationController
  #before_action :authenticate_user!
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    #@restaurant.favorites_count = @restaurant.favorites.size
    #@restaurant.save
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorite = Favorite.where(user: current_user, restaurant: @restaurant)
    favorite.destroy_all
    #@restaurant.favorites_count = @restaurant.favorites.size
    #@restaurant.save
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant = Restaurant.find(params[:id])
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)

  end

  def unlike
    @restaurant = Restaurant.find(params[:id])
    like = Like.where(user: current_user, restaurant: @restaurant)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def ranking
    @restaurant = Restaurant.order(favorites_count: :desc).limit(10)
  end
end
