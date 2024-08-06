class ResetpasswordsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_reset_password_token!
      UserMailer.forgot_password(@user).deliver_now
      flash[:success] = "Password reset instructions have been sent to your email."
        else
      flash[:danger] = "Email address not found."
    end
    redirect_to root_path
  end

  def edit
    @user = User.find_by(reset_password_token:params[:id])
    if @user.nil? || !@user.password_token_valid?
      flash[:danger] = "Invalid or expired token."
      redirect_to new_resetpassword_path
    end
  end

  def update
    @user = User.find_by(reset_password_token:params[:id])
    if @user && @user.password_token_valid?
      if @user.update(user_params)
        flash[:success] = "Password successfully updated. Please log in."
        redirect_to root_path
      else
        flash.now[:danger] = "Password incorrect"
        render :edit
      end
    else
      flash[:danger] = "Password mismatch. Enter you email to update password."
      redirect_to new_resetpassword_path
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
