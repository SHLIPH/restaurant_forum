class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! #Devise 提供的預設方法，檢查使用者是否登入
end
