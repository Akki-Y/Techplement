class SessionsController < ApplicationController
  # Login and logout credentials
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])    
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login Successful.Welcome Back"
      redirect_to homepage_path
    else
      flash.now[:danger] = "Invalid email or Password"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
end
