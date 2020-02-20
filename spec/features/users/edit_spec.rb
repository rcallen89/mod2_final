require 'rails_helper'

RSpec.describe "User Profile Edit Page", type: :feature do
  before :each do
    @user = create(:user)
    
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

      expect(current_path).to have_content("Profile Updated")
      expect(page).to have_content("Name Edited")

    end
  end
end