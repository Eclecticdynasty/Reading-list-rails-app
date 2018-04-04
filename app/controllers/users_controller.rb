class UsersController < ApplicationController
 before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create

     @user = User.new(user_params)
    if @user && @user.save
      log_user_in
      flash[:success] = "You've successfully created an account!"
      redirect_to user_path(@user)
      # redirect_to @user #/users/#{@user.id} same as user_path(@user)
    else
      flash.now[:error] = "Please enter a valid email & valid password"
      render :new #error; show user the form again
    end
  end

  def show
    redirect_to root_path unless session[:user_id] 
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile Updated"
      redirect_to user_path #success
    else
      render :edit #error; show user the form again
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
