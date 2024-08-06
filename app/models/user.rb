class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}, confirmation: true
  validates :password_confirmation, presence:true, on: :update

  def generate_reset_password_token!
    self.reset_password_token = SecureRandom.hex(10)
    self.reset_password_sent_at = Time.now.utc
    save!(validate: false)  
  end
  
  def password_token_valid?
    return false if reset_password_sent_at.nil?
    (reset_password_sent_at + 2.hours) > Time.now.utc  
  end

  def reset_password!(password, password_confirmation)
    self.password = password
    self.password_confirmation = password_confirmation
    self.reset_password_token = nil
    save(validate: true) 
  end
end
