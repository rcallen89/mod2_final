require 'rails_helper'

RSpec.describe 'Login and Logout', type: :feature do
  before :each do
    @user = create(:user)
    @employee = create(:user, role: 1, email: "employee@email.com")
    @admin = create(:user, role: 2, email: "admin@email.com")
  end
  context 'as a visitor' do
    it 'enters incorrect information and the log in fails' do
      visit "/login"

      fill_in :email, with: @user.email
      fill_in :password, with: "incorrect"

      click_on "Log In"

      expect(current_path).to eq('/login')
      expect(page).to have_content('Invalid Login')
    end

    it 'can enter correct email and password for user and log in' do
      visit "/login"

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_on "Log In"

      expect(current_path).to eq("/profile")
    end

    it 'can enter correct email and password for merchant and log in' do
      visit "/login"

      fill_in :email, with: @employee.email
      fill_in :password, with: @employee.password

      click_on "Log In"

      expect(current_path).to eq("/merchant")
    end

    it 'can enter correct email and password for admin and log in' do
      visit "/login"

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password

      click_on "Log In"

      expect(current_path).to eq("/admin")
    end

    it 'can login successfully and then log out' do
      visit "/login"

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_on "Log In"

      expect(current_path).to eq("/profile")

      click_on "Logout"

      expect(current_path).to eq('/')
      expect(page).to have_content("Cart: 0")
    end

    it "user is redirected to their profile and sees message that they are already logged in" do
      visit "/login"

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_on "Log In"

      visit "/login"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("You are already logged in.")
    end
    it "employee is redirected to their profile and sees message that they are already logged in" do
      visit "/login"

      fill_in :email, with: @employee.email
      fill_in :password, with: @employee.password

      click_on "Log In"

      visit "/login"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("You are already logged in.")
    end
    it "employee is redirected to their profile and sees message that they are already logged in" do
      visit "/login"

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password

      click_on "Log In"

      visit "/login"

      expect(current_path).to eq("/admin")
      expect(page).to have_content("You are already logged in.")
    end
  end
end
