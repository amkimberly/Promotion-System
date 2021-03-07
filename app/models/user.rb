class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :mail


  private

  def mail
    return if email.include? '@mail.com'

    errors.add(:email, 'precisa ser @mail.com')
  end
end
