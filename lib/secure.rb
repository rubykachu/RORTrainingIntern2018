# frozen_string_literal: true

class Secure
  def self.token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.authenticated?(digest, token)
    BCrypt::Password.new(digest).is_password?(token)
  end
end
