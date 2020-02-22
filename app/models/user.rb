class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :street_address, :city, :state, :zip, :role, :password_digest
  validates :email, uniqueness: true, presence: true

  has_many :orders

  enum role: %w( User MerchantEmployee Admin )

end