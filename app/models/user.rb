class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :street_address, :city, :state, :zip, :role, :password
  validates :email, uniqueness: true, presence: true

  enum role: %w('User' 'Merchant Employee' 'Admin')

end