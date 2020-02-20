require 'rails_helper'

RSpec.describe "User Profile Edit Page", type: :feature do
  before :each do
    @user = create(:user)
    @user2 = create(:user, email: "test2@email.com")
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  context 'as a user' do
    it 'can edit my profile information' do
      visit '/profile'
      click_on 'Edit Profile'
      
      expect(find_field('Name').value).to eq "#{@user.name}"
      expect(find_field('Street address').value).to eq "#{@user.street_address}"
      expect(find_field('City').value).to eq "#{@user.city}"
      expect(find_field('State').value).to eq "#{@user.state}"
      expect(find_field('Zip').value).to eq "#{@user.zip}"
      expect(find_field('Email').value).to eq "#{@user.email}"
      expect(page).not_to have_content("Password")
      
      fill_in :Name, with: "Name Edited"

      click_on "Update Profile"

      expect(current_path).to have_content("/profile")
      expect(page).to have_content("Profile Updated!")
    end

    it 'cant change to an email already taken' do
      visit '/profile'
      click_on 'Edit Profile'
      
      expect(find_field('Name').value).to eq "#{@user.name}"
      expect(find_field('Street address').value).to eq "#{@user.street_address}"
      expect(find_field('City').value).to eq "#{@user.city}"
      expect(find_field('State').value).to eq "#{@user.state}"
      expect(find_field('Zip').value).to eq "#{@user.zip}"
      expect(find_field('Email').value).to eq "#{@user.email}"
      expect(page).not_to have_content("Password")
      
      fill_in :Email, with: "test2@email.com"

      click_on "Update Profile"

      expect(current_path).to have_content("/profile/edit")
      expect(page).to have_content("Email has already been taken")
    end

    it 'can change its password' do
      visit '/profile'
      click_on 'Change Password'

      
      fill_in :Password, with: "password2"
      fill_in :user_password_confirmation, with: "password2"

      click_on "Update Password"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Password Updated")
    end
  end
end