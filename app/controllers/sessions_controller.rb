class SessionsController < ApplicationController

  def new
    @user = User.new
    redirect_to user_path if logged_in?
  end

  #login through social media or signup form
  def create
    if auth
      @user = User.set_user_from_omniauth(auth['uid'])
      log_user_in
      redirect_to recipes_path(@user), flash: {success: "You're logged in through Facebook!"}
    else
      #find user by username
      @user = User.find_by(username: params[:session][:username])
      if @user && @user.authenticate(params[:session][:password])
        log_user_in
        redirect_to recipes_path, flash: {success: "You're logged in!"}
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
