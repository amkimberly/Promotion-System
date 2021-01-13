class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :email_locaweb


  private
  def email_locaweb
    return if email.include? '@locaweb.com.br'

    errors.add(:email, "precisa ser '@locaweb.com.br'" )
  end
end
