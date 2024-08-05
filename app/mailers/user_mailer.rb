class UserMailer < ApplicationMailer
  def forgot_password(user)
    @user = user
    @url = edit_resetpassword_url(@user.reset_password_token)
    mail(to: @user.email, subject: 'reset password instructions')
  end
end
