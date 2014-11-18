class ApplicationController < ActionController::Base
 # before_filter :load_user
  before_filter :permitall
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  def load_user
      @user= current_user
  end

  def permitall
    params.permit!
  end

  def require_login
     if  session[:user_id].nil?
       redirect_to "/login"
     end

  end
end
