class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    #@user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers
  end

  def edit
    #@user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
      flash[:notice] = "user was successfully updated"
    else
      render :edit
      flash[:alert] = "user was failed to update"
    end
  end

  def index
    @users = User.all
  end

  def friend_list
    @friends = current_user.all_friends
  end

  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
