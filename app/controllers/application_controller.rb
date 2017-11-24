class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def authenticate_admin
    #current_user 是 Devise 提供的 helper method。
    #先透過 current_user 拿到 User instance，接著呼叫一個叫 admin? 的 instance method。
    #admin? 方法是等下我們要手工加入的，這個方法會去驗證 User instance 是否具有管理者身份。從命名方式，可以判斷出 admin? 會回傳 True 或 False。
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
end
