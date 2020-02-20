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

      fill


    end
  end
end