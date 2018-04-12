class SessionsController < ApplicationController

  def new
    @user = User.new
    redirect_to user_path if logged_in?
  end

  #login through social media or signup form
  def create
    if auth
      @user = User.set_user_from_omniauth(auth['uid'])
      flash[:alert] = "Invalid email/password combination"
      log_user_in
    else
      #find user by username
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password])
        log_user_in
        flash[:error] = "You're logged in!"
        redirect_to user_path(@user)
      else
        flash.now[:error] = "Invalid username/password combination"
        render 'sessions/new'
      end
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

    def auth
      request.env['omniauth.auth']
    end
    
end
