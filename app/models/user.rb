class User < ApplicationRecord
  attr_accessor :remember_token

  USER_ATTRIBUTES = [:name, :email, :password, :password_confirmation].freeze

  before_save{email.downcase!}
  validates(:name, presence: true,
            length: {maximum: Settings.validate.length_50})
  validates(:email, presence: true,
            length: {maximum: Settings.validate.length_255},
            format: {with: Settings.regex.email},
            uniqueness: true)
  validates(:password, presence: true,
            length: {minimum: Settings.validate.length_6},
            allow_nil: true)
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost:)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
