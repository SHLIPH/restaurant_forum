class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user! #Devise 提供的預設方法，檢查使用者是否登入
  before_action :authenticate_admin #等下我們要自己手工定義的方法，檢查使用者身份是否為「管理者」。

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to admin_restaurants_path
      flash[:notice] = "restaurant was successfully created"
    else
      render :new
      flash[:alert] = "restaurant was failed to create"
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurants_path(@restaurant)
      flash[:notice] = "restaurant was successfully updated"
    else
      render :edit
      flash[:alert] = "restaurant was failed to update"
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description)
  end
end
