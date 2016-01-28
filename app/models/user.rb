class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  validate :email_is_unique, on: :create
  after_create :create_account

  #To be deleted after mail validation
  def confirmation_required?
    false
  end

  private

  def email_is_unique
    unless Account.find_by(:email, email).nil?
      errors.add(:email, " is already used by another account")
    end
  end

  def create_account
    account = Account.new(email: email)
    account.save!
  end

end
