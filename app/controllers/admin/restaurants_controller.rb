class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user! #Devise 提供的預設方法，檢查使用者是否登入
  before_action :authenticate_admin #等下我們要自己手工定義的方法，檢查使用者身份是否為「管理者」。

  def index
    @restaurants = Restaurant.all
  end
end
