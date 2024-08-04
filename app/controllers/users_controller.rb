class UsersController < ApplicationController
  # User registration / Creating an account
  def new
    @user = User.new 
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created. Please Log in"
      redirect_to login_path
    else
      flash.now[:danger] = "Create an account"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
