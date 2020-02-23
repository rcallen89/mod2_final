require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :role }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe "relationships" do
    it {should have_many :merchant_employees}
    it {should have_many(:merchants).through(:merchant_employees)}
  end

  describe 'role enum' do
    it 'should list proper roles for enum' do
      user_1 = User.create(name: "Benny",
                          street_address: "123 Main Street",
                          city: "CO",
                          state: "Denver",
                          zip: "80144",
                          role: 0,
                          email: "test@example.com",
                          password: "password")

      user_2 = User.create(name: "Benny",
                          street_address: "123 Main Street",
                          city: "CO",
                          state: "Denver",
                          zip: "80144",
                          role: 1,
                          email: "test1@example.com",
                          password: "password")

      user_3 = User.create(name: "Benny",
                          street_address: "123 Main Street",
                          city: "CO",
                          state: "Denver",
                          zip: "80144",
                          role: 2,
                          email: "test3@example.com",
                          password: "password")

      expect(user_1.role).to eq("User")
      expect(user_2.role).to eq("MerchantEmployee")
      expect(user_3.role).to eq("Admin")
    end
  end
end
