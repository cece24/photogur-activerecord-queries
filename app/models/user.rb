class User < ApplicationRecord
  has_secure_password
  has_many :pictures

  validates :email, presence: true
end
