class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in? #let these methods be used in views

  #check if user logged in
  def logged_in?
    !!current_user
  end

  #if user is current user
  def current_user #returns current logged in user (if any)
    # @current_user ||= User.find(id: session[:user_id]) if session[:user_id]
    User.find_by(id: session[:user_id])
  end

  def log_user_in
    session[:user_id] = @user.id
  end
end
