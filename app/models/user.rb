class User < ApplicationRecord

  USER_ATTRIBUTES = [:name, :email, :password, :password_confirmation].freeze
  
  before_save{email.downcase!}
  validates(:name, presence: true, length: {maximum: Settings.validate.length_50})
  validates(:email, presence: true, length: {maximum: Settings.validate.length_255},
            format: {with: Settings.regex.email},
            uniqueness: true)
  validates(:password, presence: true, length: {minimum: Settings.validate.length_6})
  has_secure_password
end
