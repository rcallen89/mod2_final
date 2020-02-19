require 'rails_helper'

RSpec.describe 'Login and Logout', type: :feature do
  before :each do
    @user = create(:user)
    @employee = create(:user, role: "1", email: "employee@email.com")
    @admin = create(:user, role: "1", email: "admin@email.com")
  end
  context 'as a visitor' do
    it 'can enter email and password and log in' do
      visit "/login"
      require 'pry'; binding.pry


    end
  end
end