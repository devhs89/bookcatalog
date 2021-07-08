class Admin < ApplicationRecord
  has_secure_password

  # A regex to validate email address and requiring password
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :password, presence: true
end
